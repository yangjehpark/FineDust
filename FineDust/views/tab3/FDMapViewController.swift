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
    @IBOutlet weak var hereButton: UIButton!
    @IBOutlet weak var progressView: UIView!
    private var webLoadProgress: Double = 0 {
        didSet {
            UIView.animate(withDuration: 0.25) {
                self.progressView.alpha = CGFloat(1-self.webLoadProgress)
            }
        }
    }
    private var indicator: NVActivityIndicatorView?
    enum IndicatorType {
        case loading, sharing
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title = "satellite".localized
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainWebView.navigationDelegate = self
        mainWebView.scrollView.delegate = self
        
        addObserverOnProgress()
        setupHereButton()
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topNavigationItem?.title = "satellite".localized
        hideHereImage()
        hideHereButton()
    }
    
    @IBAction func reloadData() {
        showHereImage()
        hideHereButton()
        mainWebView.reload()
    }
    
    @IBAction func shareButtonPressed() {
        showIndicator(.sharing)
        ScreenshotHelper.takeGIF(targetView: mapBackgroundView) { (gifData: Data?, gifLocalURL: URL?) in
            self.hideIndicator()
            if let url = gifLocalURL {
                let activityItem: [AnyObject] = [url as AnyObject]
                let avc = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
                DispatchQueue.main.async {
                    ViewControllerHelper.topViewController()?.present(avc, animated: true, completion: nil)
                }
            } else {
                log("no url")
            }
        }
    }
    
    @IBAction func hereButtonPressed() {
        showHereImage()
        hideHereButton()
        mainWebView.reload()
    }
    
    private func setupHereButton() {
        hereButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        hereButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        hereButton.layer.masksToBounds = true
        hereButton.layer.cornerRadius = 5
        hereButton.layer.borderColor = UIColor.white.cgColor
        hereButton.layer.borderWidth = 1
    }
    
    private func load() {
        GeoManager.shared.getCurrentLocation { (geo) in
            guard let geo = geo else {
                self.loadFail()
                return
            }
            let zLevels = 4000
            let urlString: String = "https://www.airvisual.com/earth#current/wind/surface/level/orthographic=\(geo.longitude),\(geo.latitude),\(zLevels)"
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

extension FDMapViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideHereImage()
        showHereButton()
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        hideHereImage()
        showHereButton()
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
        showIndicator(.loading)
        showProgressView()
        hideHereImage()
        hideHereButton()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private func loadFail() {
        hideIndicator()
        hideProgressView()
        hideHereImage()
        hideHereButton()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    private func loadComplete() {
        hideIndicator()
        hideProgressView()
        showHereImage()
        hideHereButton()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension FDMapViewController: NVActivityIndicatorViewable {
    
    func showIndicator(_ type: IndicatorType) {
        switch type {
        case .loading:
            startAnimating(CGSize(width: 100, height: 100), message: "Loading", messageFont: .boldSystemFont(ofSize: 20), type: .ballScaleRippleMultiple, color: .white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: 1, backgroundColor: .clear, textColor: .white)
        case .sharing:
            startAnimating(CGSize(width: 100, height: 100), message: "Preparing", messageFont: .boldSystemFont(ofSize: 20), type: .ballScaleMultiple, color: .white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: 1, backgroundColor: .clear, textColor: .white)
        }
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

    func showHereButton() {
        hereButton.isHidden = false
    }
    
    func hideHereButton() {
        hereButton.isHidden = true
    }
}
