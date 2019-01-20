//
//  ViewUtils.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 2..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit

class ViewUtils {
    
    /// Get screen width
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    /// Get screen height
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    
    // addSubView
    static func addSubView(parent: UIView, child: UIView, leading: CGFloat = 0, tailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        child.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(child)
        align(parent, child, leading, tailing, top, bottom)
    }
    
    // addSubView
    static func addSubView(parent: UIView, child: UIView, at: Int, leading: CGFloat = 0, tailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        child.translatesAutoresizingMaskIntoConstraints = false
        parent.insertSubview(child, at: at)
        align(parent, child, leading, tailing, top, bottom)
    }
    
    // setWidth
    @discardableResult
    static func setWidth(_ view: UIView, _ value: CGFloat) -> NSLayoutConstraint {
        return makeEqual(view, value, .width, .width)
    }
    
    // setHeight
    @discardableResult
    static func setHeight(_ view: UIView, _ value: CGFloat) -> NSLayoutConstraint {
        return makeEqual(view, value, .height, .height)
    }
    
    // align
    static func align(_ parent: UIView, _ child: UIView, _ leading: CGFloat = 0, _ tailing: CGFloat = 0, _ top: CGFloat = 0, _ bottom: CGFloat = 0) {
        alignTop(parent, child, top)
        alignBottom(parent, child, bottom)
        alignLeft(parent, child, leading)
        alignRight(parent, child, tailing)
    }
    
    // top
    @discardableResult
    static func alignTop(_ parent: UIView, _ child: UIView, _ value: CGFloat = 0) -> NSLayoutConstraint {
        return makeEqual(parent, child, value, .top, .top)
    }
    
    // bottom
    @discardableResult
    static func alignBottom(_ parent: UIView, _ child: UIView, _ value: CGFloat = 0) -> NSLayoutConstraint {
        return makeEqual(parent, child, value, .bottom, .bottom)
    }
    
    // left
    @discardableResult
    static func alignLeft(_ parent: UIView, _ child: UIView, _ value: CGFloat = 0) -> NSLayoutConstraint {
        return makeEqual(parent, child, value, .left, .left)
    }
    
    // right
    @discardableResult
    static func alignRight(_ parent: UIView, _ child: UIView, _ value: CGFloat = 0) -> NSLayoutConstraint {
        return makeEqual(parent, child, value, .right, .right)
    }
    
    // makeEqual
    @discardableResult
    static func makeEqual(_ parent: UIView, _ child: UIView, _ value: CGFloat, _ attr1: NSLayoutAttribute, _ attr2: NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: child,
            attribute: attr1,
            relatedBy: NSLayoutRelation.equal,
            toItem: parent,
            attribute: attr2,
            multiplier: 1,
            constant: value
        )
        parent.addConstraint(constraint)
        return constraint
    }
    
    // makeEqual
    @discardableResult
    static func makeEqual(_ view: UIView, _ value: CGFloat, _ attr1: NSLayoutAttribute, _ attr2: NSLayoutAttribute) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: view,
            attribute: attr1,
            relatedBy: NSLayoutRelation.equal,
            toItem: nil,
            attribute: attr2,
            multiplier: 1,
            constant: value
        )
        view.addConstraint(constraint)
        return constraint
    }
    
    static let zeroHeight: CGFloat = 0.01
}
