//
//  InitViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 2..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView
//import PRTMCoordTrans

class InitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let indicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), type: NVActivityIndicatorType.ballClipRotateMultiple, color: .red, padding: nil)
            view.addSubview(indicatorView)
            indicatorView.center = view.center
            indicatorView.startAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !GeoManager.shared.isAuthorized {
            GeoManager.shared.requestPermission()
            /*
            GeoManager.shared.showAlertOfRequestPermission(vc: self, {
                GeoManager.shared.requestPermission()
            })
             */
        }
        
        GeoManager.shared.getCurrentLocation { (geo: GeoCoordinate?) in
            if (geo != nil) {
                log("location = \(geo!.latitude) : \(geo!.longitude)")
                
                let parameter = AQIParameters.GeoFeed(lat: geo!.latitude, lng: geo!.longitude, optional: nil)
                
                /*
                self.getAKStationFeed(geo: geo!, completionHandler: { (stationFeedResponse:AKStationFeedResponse?) in
                    if let data = stationFeedResponse?.list?[safe: 0] {
                        self.success(data: data)
                    } else {
                        log("fail")
                    }
                })
                */
                
                self.getAQIGeoFeed(parameter: parameter, completionHandler:
                    { (response:AQIGeoFeedResponse?) in
                        if response != nil {
                            self.success(data: response!.data)
                        } else {
                            self.getAQIIPFeed(completionHandler: { (response:AQIIPFeedResponse?) in
                                if response != nil  {
                                    self.success(data: response!.data)
                                } else {
                                    log("error")
                                }
                            })
                        }
                })
                 
                
                KakaoAPI.getAddressName(parameter: KakaoParameters.Geo(lat: geo!.latitude, lng: geo!.longitude), completionHandler: { (response: KakaoAddressNameResponse?) in
                    if let addressName = response?.documents?[safe:0]?.address_name {
                        DataManager.shared.setCurrentAreaData(addressName)
                    }
                })
                
            } else {
                log("getting location fail")
                self.getAQIIPFeed(completionHandler: { (response:AQIIPFeedResponse?) in
                    if response != nil {
                        self.success(data: response!.data)
                    } else {
                        log("error")
                    }
                })
            }
        }
    }
    
    private func getAQIGeoFeed(parameter: AQIParameters.GeoFeed, completionHandler: @escaping (AQIGeoFeedResponse?) -> Void) {
        AQIAPIs.getGeoFeed(parameter: parameter) { (response:AQIGeoFeedResponse?, error: Error?) in
            completionHandler(response)
        }
    }
    
    private func getAQIIPFeed(completionHandler: @escaping (AQIIPFeedResponse?) -> Void) {
        AQIAPIs.getIPFeed(parameter: AQIParameters.IPFeed()) { (response:AQIIPFeedResponse?, error:Error?) in
            completionHandler(response)
        }
    }
    
    private func getAKStationFeed(geo: GeoCoordinate, completionHandler: @escaping (AKStationFeedResponse?) -> Void) {
        /*
        if let tm = PRTMCoordTrans.wgs84IntoTM128(withLatitude: geo.latitude, longitude: geo.longitude), let tmX = tm[safe:0] as? Double, let tmY = tm[safe:1] as? Double {
            
            let parameter = AKParameters.NearbyPoint(tmX: tmX, tmY: tmY)
            
            AKAPIs.Station.getNearbyPoints(parameter, completionHandler: { (nearbyPointResponse: AKNearbyPointResponse?) in
                
                if let stationName = nearbyPointResponse?.list?[safe:0]?.stationName {
                    
                    let parameter = AKParameters.StationFeed(stationName: stationName, ver: nil)
                    AKAPIs.Measure.getStationFeed(parameter, completionHandler: { (stationFeedResponse: AKStationFeedResponse?) in
                        
                        completionHandler(stationFeedResponse)
                    })
                } else {
                    log("Can't get nearby point")
                    completionHandler(nil)
                }
            })
        } else {
            log("Can't get TM128 coordinate")
            completionHandler(nil)
        }
         */
    }
    
    private func success(data: AQIData?) {
        DataManager.shared.setCurrentAreaData(data)
        self.goRootVC()
    }
    
    private func success(data: AKData?) {
        DataManager.shared.setCurrentAreaData(data)
        self.goRootVC()
    }
    
    func goRootVC() {
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FDRootViewController")
        ViewControllerHelper.loadAsRoot(rootVC)
    }
}
