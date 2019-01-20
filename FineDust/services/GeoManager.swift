//
//  GeoManager.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 4..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit
import CoreLocation

typealias GeoCoordinate = (latitude:Double, longitude:Double)

extension Notification.Name {
    enum LocationUpdate {
        static let success = Notification.Name(rawValue: "LocationUpdatedSuccess")
        static let fail = Notification.Name(rawValue: "LocationUpdatedFail")
    }
}

class GeoManager: NSObject {
    /// Get an unique shared instance
    static let shared = GeoManager()
    /// CLLocationManager controlled by GeoManager
    private var locationManager: CLLocationManager?
    /// Currnet location infomation
    private var currentLocation: CLLocation?
    /// Currnet location name
    var currentLocationName: String?
    
    
    var locationUpdatedObserver: Any?
    var failToUpdateObserver: Any?
    
    override init() {
        super.init()
        initManager()
    }
    
    func showAlertOfRequestPermission(vc: UIViewController, _ completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "", message: "It's going to show alret. Press 'Allow' to access your loaction.", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        vc.show(alert, sender: nil)
    }
    
    var isAuthorized: Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            }
        } else {
            log("Location services are not enabled")
            return false
        }
    }
    
    func requestPermission() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func initManager() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }
    }
    
    func startUpdatingLocation() {
        initManager()
        locationManager?.startUpdatingLocation()
    }
    
    func finishUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
        locationManager = nil
    }
    
    func sendSettingApp() {
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    func getCurrentLocation(completionHandler: @escaping (_ geo: GeoCoordinate?) -> Void) {
        startUpdatingLocation()
        
        if currentLocation != nil {
            let coordinate: GeoCoordinate = (latitude: Double(currentLocation!.coordinate.latitude), longitude: Double(currentLocation!.coordinate.longitude))
            completionHandler(coordinate)
        } else {
            locationUpdatedObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.LocationUpdate.success, object: nil, queue: OperationQueue.main) { (notification: Notification) in
                if let location = notification.object as? CLLocation {
                    let coordinate: GeoCoordinate = (latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude))
                    completionHandler(coordinate)
                } else {
                    completionHandler(nil)
                }
                if self.locationUpdatedObserver != nil {
                    NotificationCenter.default.removeObserver(self.locationUpdatedObserver!)
                }
            }
            failToUpdateObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.LocationUpdate.fail, object: nil, queue: OperationQueue.main) { (notification: Notification) in
                if let location = notification.object as? CLLocation {
                    let coordinate: GeoCoordinate = (latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude))
                    completionHandler(coordinate)
                } else {
                    completionHandler(nil)
                }
                if self.failToUpdateObserver != nil {
                    NotificationCenter.default.removeObserver(self.failToUpdateObserver!)
                }
            }
        }
    }
}

extension GeoManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // The user has not yet made a choice regarding whether this app can use location services.
            log("didChangeAuthorization - notDetermined")
            break
        case .restricted:
            // This app is not authorized to use location services.
            log("didChangeAuthorization - restricted")
            break
        case .denied:
            // The user explicitly denied the use of location services for this app or location services are currently disabled in Settings.
            log("didChangeAuthorization - denied")
            break
        case .authorizedAlways:
            // This app is authorized to start location services at any time.
            log("didChangeAuthorization - authorizedAlways")
            break
        case .authorizedWhenInUse:
            // This app is authorized to start most location services while running in the foreground.
            log("didChangeAuthorization - authorizedWhenInUse")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let recentLocation = locations.last {
            log("The location was updated.")
            currentLocation = recentLocation
            NotificationCenter.default.post(name: NSNotification.Name.LocationUpdate.success, object: recentLocation)
            // Update only at once.
            finishUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name.LocationUpdate.fail, object: nil)
    }
}
