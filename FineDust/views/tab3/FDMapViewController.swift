//
//  FDMapViewController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 2..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import WebKit

class FDMapViewController: UIViewController {

    @IBOutlet weak var topNavigationItem: UINavigationItem?
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var verticalStepper: VerticalStepper!
    private var webLoadProgress: Double = 0 {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.progressView.alpha = CGFloat(1-self.webLoadProgress)
            }
            if webLoadProgress == 1 {
                loadComplete()
            }
        }
    }
    private var indicator: NVActivityIndicatorView?
    
    /// if value is larger, then area looks larger
    let zLevels = [4000, 2000, 1000, 500]
    var zIndex: Int = 0 {
        didSet {
            if zIndex < 0 { zIndex = 0 }
            if zIndex > zLevels.count-1 { zIndex = zLevels.count-1 }
            if oldValue != zIndex {
                reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainWebView.isUserInteractionEnabled = false
        
        addObserverOnProgress()
        setVerticalStepper()
        loadStart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topNavigationItem?.title = "satellite".localized
    }
    
    @IBAction func reloadData() {
        loadStart()
    }
    
    @IBAction func shareButtonPressed() {
        print("shareButtonPressed")
    }
}

extension FDMapViewController {
    
    func loadStart() {
        showIndicator()
        showProgressView()
        let urlString: String = "https://www.airvisual.com/earth#current/wind/surface/level/orthographic=\(Constants.Sejong.longitude),\(Constants.Sejong.latitude),\(zLevels[zIndex])"
        mainWebView.load(URLRequest(url: URL(string: urlString)!))
        print(urlString)
    }
    
    func loadComplete() {
        hideIndicator()
        hideProgressView()
    }
}

extension FDMapViewController {
    
    func addObserverOnProgress() {
        mainWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            webLoadProgress = mainWebView.estimatedProgress
        }
    }
}

extension FDMapViewController: NVActivityIndicatorViewable {
    
    func showIndicator() {
        startAnimating(CGSize(width: 100, height: 100), message: "Loading", messageFont: .boldSystemFont(ofSize: 20), type: .ballScaleRippleMultiple, color: .white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: 1, backgroundColor: .clear, textColor: .white)
    }
    
    func hideIndicator() {
        stopAnimating()
    }
}

extension FDMapViewController {

    func showProgressView() {
        progressView.isHidden = false
        progressView.alpha = 1
    }
    
    func hideProgressView() {
        progressView.isHidden = true
        progressView.alpha = 0
    }
}

extension FDMapViewController {
    
    func setVerticalStepper() {
        verticalStepper.backgroundColor = .clear
        verticalStepper.addTarget(self, action: #selector(verticalStepperIncresed), for: .increased)
        verticalStepper.addTarget(self, action: #selector(verticalStepperDecresed), for: .decreased)
    }

    @objc func verticalStepperIncresed() {
        zIndex -= 1
    }
    
    @objc func verticalStepperDecresed() {
        zIndex += 1
    }
}
