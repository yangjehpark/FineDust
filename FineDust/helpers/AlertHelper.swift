//
//  AlertHelper.swift
//  FineDust
//
//  Created by YangJehPark on 27/01/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class AlertHelper {
    
    /// 1 button only
    static func show(_ vc: UIViewController?, title: String?, body: String?, completionHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.view.tintColor = .black
        present(alert, completionHandler: completionHandler)
    }

    /// 1 button only + attributed body
    static func show(_ vc: UIViewController?, title: String?, attributedBody: NSMutableAttributedString, completionHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
        alert.setValue(attributedBody, forKey: "attributedMessage")
        alert.addAction(cancelAction)
        alert.view.tintColor = .black
        present(alert, completionHandler: completionHandler)
    }
    
    /// 2 buttons
    static func show(title: String?, body: String?, action: @escaping () -> Void, completionHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK".localized, style: .default) { (alertAction) in
            action()
        }
        let cancelAction = UIAlertAction.init(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, completionHandler: completionHandler)
    }
    
    private static func present(_ alert: UIAlertController, completionHandler: (() -> Void)?) {
        alert.view.tintColor = .black
        ViewControllerHelper.topViewController()?.present(alert, animated: true, completion: completionHandler)
    }
}
