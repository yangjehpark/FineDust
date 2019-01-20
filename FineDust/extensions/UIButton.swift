//
//  UIButton.swift
//  FineDust
//
//  Created by USER on 2018. 4. 11..
//  Copyright © 2018년 USER. All rights reserved.
//

import UIKit

typealias UIButtonTargetClosure = (UIButton) -> ()

class UIButtonClosureWrapper: NSObject {
    
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
    let closure: UIButtonTargetClosure
}

extension UIButton {
    
    func addTarget(closure: @escaping UIButtonTargetClosure, for controlEvents: UIControlEvents) {
        targetClosure = closure
        addTarget(nil, action: #selector(UIButton.closureAction), for: controlEvents)
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
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? UIButtonClosureWrapper else {
                return nil
            }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else {
                return
            }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, UIButtonClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
