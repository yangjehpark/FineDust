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

class FDMapViewController: FDViewController {

    @IBOutlet weak var topNavigationItem: UINavigationItem?
    @IBOutlet weak var mapBackgroundView: UIView!
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var hereImageView: UIImageView!
    @IBOutlet weak var hereImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var verticalStepper: VerticalStepper!
    private var webLoadProgress: Double = 0 {
        didSet {
            UIView.animate(withDuration: 0.25) {
                self.progressView.alpha = CGFloat(1-self.webLoadProgress)
            }
        }
    }
    private var indicator: NVActivityIndicatorView?
    
    /// if value is larger, then area looks larger
    let zLevels = [4000, 2000, 1000, 500]
    var zIndex: Int = 0 {
        didSet {
            let minimum = 0
            let maximum = zLevels.count-1
            if zIndex < minimum { zIndex = minimum }
            if zIndex > maximum { zIndex = maximum }
            if oldValue != zIndex {
                reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title = "satellite".localized
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainWebView.isUserInteractionEnabled = false
        mainWebView.navigationDelegate = self
        
        addObserverOnProgress()
        setVerticalStepper()
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topNavigationItem?.title = "satellite".localized
    }
    
    @IBAction func reloadData() {
        load()
    }
    
    @IBAction func shareButtonPressed() {
        showIndicator()
        ScreenshotHelper.takeGIF(targetView: mapBackgroundView) { (gifURL: URL?) in
            self.hideIndicator()
            if let gifURL = gifURL {
                // TODO: send to share
                ScreenshotHelper.cleanGIF()
            }
        }
    }
    
    private func load() {
        GeoManager.shared.getCurrentLocation { (geo) in
            guard let geo = geo else {
                self.loadFail()
                return
            }
            let urlString: String = "https://www.airvisual.com/earth#current/wind/surface/level/orthographic=\(geo.longitude),\(geo.latitude),\(self.zLevels[self.zIndex])"
            self.adjustHereImageViewWidth()
            self.mainWebView.load(URLRequest(url: URL(string: urlString)!))
            log(urlString)
        }
    }
}

extension FDMapViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadStart()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadFail()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadComplete()
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
    
    private func loadStart() {
        showIndicator()
        showProgressView()
        hideHereImage()
    }
    
    private func loadFail() {
        hideIndicator()
        hideProgressView()
        hideHereImage()
    }
    
    private func loadComplete() {
        hideIndicator()
        hideProgressView()
        showHereImage()
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
    
    func showHereImage() {
        hereImageView.isHidden = false
    }
    
    func hideHereImage() {
        hereImageView.isHidden = true
    }
    
    func adjustHereImageViewWidth() {
        let value = zLevels[zIndex]
        let width = CGFloat(value/100)
        hereImageViewWidth.constant = width
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
