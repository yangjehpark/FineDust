//
//  FDNavigationController.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 2..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class FDNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navigationBar
        do {
            navigationBar.isTranslucent = false
            navigationBar.tintColor = .white
            navigationBar.barTintColor = UIColor.red
            navigationBar.shadowImage = UIImage()
            navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
    }
}
