//
//  FDMapViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 2..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FDMapViewController: UIViewController {

    @IBOutlet weak var mainWebView: UIWebView!
    var indicator: NVActivityIndicatorView?
    
    /// if value is larger, then area looks larger
    let zValue: Int = 3000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainWebView.delegate = self
        mainWebView.isUserInteractionEnabled = false

        reloadData()
    }
    
    @IBAction func sideMenuButtonPressed() {
        ViewControllerHelper.openSideMenu(vc: self)
    }

    @IBAction func reloadData() {
        let urlString: String = "https://www.airvisual.com/earth#current/wind/surface/level/orthographic=\(Constants.Sejong.longitude),\(Constants.Sejong.latitude),\(zValue)"
        let request = URLRequest(url: URL(string: urlString)!)
        mainWebView.loadRequest(request)
    }
}

extension FDMapViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        log("webViewDidStartLoad")
        showIndicator()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        log("webViewDidFinishLoad")
        hideIndicator()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        log("didFailLoadWithError")
        hideIndicator()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        log("shouldStartLoadWith")
        return true
    }
}

extension FDMapViewController: NVActivityIndicatorViewable {
    
    func showIndicator() {
        startAnimating(CGSize(width: 60, height: 60), message: "Please wait...", messageFont: .systemFont(ofSize: 15), type: .ballClipRotateMultiple, color: .red, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: 1, backgroundColor: UIColor(r: 15, g: 15, b: 15, a: 0.25), textColor: .red)
    }
    
    func hideIndicator() {
        stopAnimating()
    }
}
