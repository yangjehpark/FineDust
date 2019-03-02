//
//  ViewControllerHelper.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 2..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class ViewControllerHelper {
    
    /// Set application Root VC
    static func loadAsRoot(_ vc: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    /// LxNavigationController의 root으로써 LxNavigationController로 감싸서 return
    static func wrapWithDefaultNavigationController(_ vc: UIViewController) -> UIViewController {
        return FDNavigationController(rootViewController: vc)
    }
    
    static func openSideMenu(vc: FDViewController) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FDMenuNavigationViewController")
        vc.present(nav, animated: true, completion: nil)
    }
    
    static func openAddArea(vc: FDViewController) {
        let modal = FDAddAreaViewController()
        modal.modalTransitionStyle = .coverVertical
        modal.modalPresentationStyle = .overFullScreen
        modal.superVC = vc
        vc.present(modal, animated: true) {
            
        }
    }
    
    static func openEditArea(vc: FDViewController) {
        let modal = FDEditAreaViewController()
        modal.modalTransitionStyle = .coverVertical
        modal.modalPresentationStyle = .overFullScreen
        modal.superVC = vc
        vc.present(modal, animated: true) {
            
        }
    }
    
    static func topViewController(_ vc: UIViewController? = nil) -> UIViewController? {
        let base: UIViewController? = vc ?? UIApplication.shared.keyWindow?.rootViewController
        if let nav = base as? UINavigationController {
            return ViewControllerHelper.topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return ViewControllerHelper.topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return ViewControllerHelper.topViewController(presented)
        }
        return base
    }
}
