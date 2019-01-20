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
    
    static func openSideMenu(vc: UIViewController) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FDMenuNavigationViewController")
        vc.present(nav, animated: true, completion: nil)
    }
    
    static func openAddArea(vc: UIViewController) {
        let modal = FDAddAreaViewController()
        modal.modalTransitionStyle = .coverVertical
        modal.modalPresentationStyle = .overFullScreen
        modal.superVC = vc
        vc.present(modal, animated: true) {
            
        }
    }
    
    static func openEditArea(vc: UIViewController) {
        let modal = FDEditAreaViewController()
        modal.modalTransitionStyle = .coverVertical
        modal.modalPresentationStyle = .overFullScreen
        modal.superVC = vc
        vc.present(modal, animated: true) {
            
        }
    }
}
