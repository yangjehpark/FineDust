//
//  UIViewController.swift
//  BitMax
//
//  Created by USER on 2018. 3. 5..
//  Copyright © 2018년 USER. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func fdNavigaionEmbedded() -> UINavigationController {
        return UINavigationController(rootViewController: self.init())
    }
    
    func fdSetNavigationBar(title text: String, color: UIColor = .black, font: UIFont = UIFont.systemFont(ofSize: 18.0)) {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = font
        label.sizeToFit()
        
        navigationItem.titleView = label
    }
    
    func fdSetNavigationBar(title text: String, color: UIColor = .black) {
        fdSetNavigationBar(title: text, color: color, font: UIFont.systemFont(ofSize: 18.0))
    }
    
    func fdSetNavigationBar(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.sizeToFit()
        
        navigationItem.titleView = imageView
    }
    
    // 네비게이션 루트인경우 닫기 버튼을 아닌 경우 백버튼을 알아서 표시
    func fdSetupNavigationButttonAutomatically() {
        guard let navigationController = self.navigationController
            else { return }
        
        if navigationController.viewControllers.first == self {
            fdSetupNavigationCloseButtton()
        } else {
            fdSetupNavigationBackButtton()
        }
    }
    
    func fdSetupNavigationCloseButtton(_ isLightContent: Bool = false) {
        let image: UIImage = isLightContent ? #imageLiteral(resourceName: "ic_close") : #imageLiteral(resourceName: "ic_close")
        let buttonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal),
                                         style: .plain, target: self, action: #selector(didTapClose(_:)))
        navigationItem.setLeftBarButton(buttonItem, animated: false)
    }
    
    func fdSetupNavigationCloseButtton(image: UIImage) {
        let buttonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal),
                                         style: .plain, target: self, action: #selector(didTapClose(_:)))
        navigationItem.setLeftBarButton(buttonItem, animated: false)
    }
    
    func fdSetupNavigationBackButtton(_ image: UIImage) {
        let buttonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal),
                                         style: .plain, target: self, action: #selector(didTapBack(_:)))
        navigationItem.setLeftBarButton(buttonItem, animated: false)
    }
    
    func fdSetupNavigationBackButtton() {
        fdSetupNavigationBackButtton(#imageLiteral(resourceName: "ic_back"))
    }
    
    func fdSetupNavigationRightButtton(_ image: UIImage) {
        let buttonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal),
                                         style: .plain, target: self, action: #selector(didTapRight(_:)))
        navigationItem.setRightBarButton(buttonItem, animated: false)
    }
    
    func fdSetupNavigationRightCustomButtton(_ view: UIView) {
        let buttonItem = UIBarButtonItem(customView: view)
        buttonItem.target = self
        buttonItem.action = #selector(didTapRight(_:))
        navigationItem.setRightBarButton(buttonItem, animated: false)
    }
    
    /// Tag will be numbered by the index of Array of UIView order
    func fdSetupNavigationRightCustomButttons(_ views: [UIView]) {
        var items = [UIBarButtonItem]()
        for (index, view) in views.enumerated() {
            view.tag = index
            let buttonItem = UIBarButtonItem(customView: view)
            buttonItem.target = self
            //buttonItem.action = #selector(didTapRight(_:))
            items.append(buttonItem)
        }
        navigationItem.setRightBarButtonItems(items, animated: true)
    }
    
    @objc func didTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapRight(_ sender: Any) { }
}
