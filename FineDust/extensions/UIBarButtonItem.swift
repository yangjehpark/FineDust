//
//  UIBarButtonItem.swift
//  FineDust
//
//  Created by USER on 2018. 4. 11..
//  Copyright © 2018년 USER. All rights reserved.
//

import UIKit

typealias UIBarButtonItemTargetClosure = (UIBarButtonItem) -> ()

class UIBarButtonItemClosureWrapper: NSObject {

    init(_ closure: @escaping UIBarButtonItemTargetClosure) {
        self.closure = closure
    }
    let closure: UIBarButtonItemTargetClosure
}

extension UIBarButtonItem {
    
    convenience init(title: String?, style: UIBarButtonItemStyle, closure: @escaping UIBarButtonItemTargetClosure) {
        self.init(title: title, style: style, target: nil, action: nil)
        targetClosure = closure
        action = #selector(UIBarButtonItem.closureAction)
    }
    
    convenience init(image: UIImage?, style: UIBarButtonItemStyle, closure: @escaping UIBarButtonItemTargetClosure) {
        self.init(image: image, style: style, target: nil, action: nil)
        targetClosure = closure
        action = #selector(UIBarButtonItem.closureAction)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else {
            return
        }
        targetClosure(self)
    }
    
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIBarButtonItemTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIBarButtonItemClosureWrapper else {
                return nil
            }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else {
                return
            }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIBarButtonItemClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
