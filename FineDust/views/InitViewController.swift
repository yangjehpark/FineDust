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
            if let geo = geo {
                log("location = \(geo.latitude) : \(geo.longitude)")
                
                let parameter = AQIParameters.GeoFeed(lat: geo.latitude, lng: geo.longitude, optional: nil)
                
                self.getAQIGeoFeed(parameter: parameter, completionHandler: { (response:AQIGeoFeedResponse?) in
                        if let response = response {
                            self.success(data: response.data)
                        } else {
                            self.getAQIIPFeed(completionHandler: { (response:AQIIPFeedResponse?) in
                                if let response = response {
                                    self.success(data: response.data)
                                } else {
                                    log("error")
                                }
                            })
                        }
                })

                print(Bundle.main.localizations)
                switch Locale.current.languageCode {
                case "ko":
                    KakaoAPI.getAddressName(parameter: KakaoParameters.Geo(lat: geo.latitude, lng: geo.longitude), completionHandler: { (response: KakaoAddressNameResponse?) in
                        if let response = response {
                            DataManager.shared.setCurrentAreaData(response)
                        }
                    })
                case "Base", "en":
                    break
                default:
                    break
                }
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
