//
//  VerticalStepper.swift
//  VerticalStepper
//
//  Created by Christian Schraga on 5/3/17.
//  Copyright © 2017 Straight Edge Digital. All rights reserved.
//
import UIKit

extension UIControlEvents {
    static var increased: UIControlEvents { return UIControlEvents(rawValue: 0b0001 << 24) }
    static var decreased: UIControlEvents { return UIControlEvents(rawValue: 0b0010 << 24) }
}

enum VerticalStepperComponents: Int {
    case minus  = 0,
    plus   = 1
}

@IBDesignable class VerticalStepper: UIControl {
    
    //constants
    let kDuration = 0.3
    
    //subviews
    var minus: Minus!
    var plus:  Plus!
    fileprivate var justaLine: JustALine!
    fileprivate var minusShade: UIView!
    fileprivate var plusShade:  UIView!
    
    //formatting attributes
    var bgHighlightColor = UIColor(r: 0, g: 0, b: 0, a: 0.175)
    var lineColor        = UIColor(r: 122, g: 122, b: 122).cgColor{
        didSet{
            minus.lineColor = self.lineColor
            plus.lineColor  = self.lineColor
        }
    }
    var buttonScale         = CGFloat(0.60){  //a 0 to 1 scale
        didSet{
            minus.buttonScale = self.buttonScale
            plus.buttonScale  = self.buttonScale
        }
    }
    var lineThickness    = CGFloat(2.0){
        didSet{
            minus.lineThickness = self.lineThickness
            plus.lineThickness  = self.lineThickness
        }
    }
    var cornerRadius = CGFloat(4.0)
    
    //flags
    var highlightedComponent: VerticalStepperComponents?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(){
        super.init(frame: CGRect.zero)
        setup()
    }
    
    fileprivate func setup(){
        
        self.justaLine = JustALine(frame: self.bounds)
        self.justaLine.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.justaLine.clipsToBounds   = true
        self.justaLine.backgroundColor = UIColor.clear
        self.justaLine.isUserInteractionEnabled = false
        
        
        let x = self.bounds.minX
        let h = self.bounds.height/2.0
        let w = self.bounds.width
        var y = self.bounds.minY
        self.plus = Plus(frame: CGRect(x: x, y: y, width: w, height: h))
        self.plus.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.plus.backgroundColor = UIColor.clear
        
        self.plusShade = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        self.plusShade.backgroundColor = bgHighlightColor
        self.plusShade.isUserInteractionEnabled = false
        self.plusShade.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.plusShade.alpha = 0.0
        
        y += h
        self.minus = Minus(frame: CGRect(x: x, y: y, width: w, height: h))
        self.minus.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.minus.backgroundColor = UIColor.clear
        
        self.minusShade = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        self.minusShade.backgroundColor = bgHighlightColor
        self.minusShade.isUserInteractionEnabled = false
        self.minusShade.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.minusShade.alpha = 0.0
        
        var buttons = [Minus]()
        buttons.append(self.plus)
        buttons.append(self.minus)
        for button in buttons{
            button.lineColor        = self.lineColor
            button.buttonScale      = self.buttonScale
            button.lineThickness    = self.lineThickness
            button.isUserInteractionEnabled = false
        }
        
        justaLine.lineColor         = self.lineColor
        
        self.addSubview(minusShade)
        self.addSubview(plusShade)
        self.addSubview(justaLine)
        self.addSubview(plus)
        self.addSubview(minus)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        var touchedNow: VerticalStepperComponents?
        let loc = touch.location(in: self)
        if plus.frame.contains(loc) {
            touchedNow = .plus
            print("begin clicked plus")
        } else if minus.frame.contains(loc){
            touchedNow = .minus
            print("begin clicked minus")
        }
        
        let result = highlightAsNeeded(touchedNow: touchedNow)
        return result
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        var touchedNow: VerticalStepperComponents?
        let loc = touch.location(in: self)
        if !self.bounds.contains(loc){
            print("touch outside")
            self.deHighlightAsNeeded()
            return false
        }
        
        if plus.frame.contains(loc) {
            touchedNow = .plus
            print("continue clicked plus")
        } else if minus.frame.contains(loc){
            touchedNow = .minus
            print("continue clicked minus")
        }
        let result = highlightAsNeeded(touchedNow: touchedNow)
        return result
    }
    
    override func cancelTracking(with event: UIEvent?) {
        self.deHighlightAsNeeded()
        print("cancel tracking")
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        var touchedNow: VerticalStepperComponents?
        
        if let touch = touch {
            let loc = touch.location(in: self)
            if plus.frame.contains(loc) {
                touchedNow = .plus
                print("end clicked plus")
            } else if minus.frame.contains(loc){
                touchedNow = .minus
                print("end clicked minus")
            }
        }
        
        if let touchedNow = touchedNow {
            if touchedNow == .plus {
                sendActions(for: .increased)
            } else {
                sendActions(for: .decreased)
            }
        }
        
        self.deHighlightAsNeeded()
    }
    
    //Helpers
    internal func highlightAsNeeded(touchedNow: VerticalStepperComponents?) -> Bool{
        if let touchedNow = touchedNow{
            let isPlus = touchedNow == .plus
            
            if let touchedBefore = self.highlightedComponent{
                if touchedNow == touchedBefore {
                    //do nothing
                    return true
                } else {
                    //turn off one and on the other
                    UIView.animate(withDuration: kDuration, delay: 0.0, options: .curveEaseInOut, animations: {
                        self.plusShade.alpha  = isPlus ? 1.0 : 0.0
                        self.minusShade.alpha = isPlus ? 0.0 : 1.0
                    }, completion: { (finished) in
                        self.highlightedComponent = isPlus ? VerticalStepperComponents.plus : VerticalStepperComponents.minus
                    })
                }
            } else {
                UIView.animate(withDuration: kDuration, delay: 0.0, options: .curveEaseInOut, animations: {
                    if isPlus {
                        self.plusShade.alpha  = 1.0
                    } else {
                        self.minusShade.alpha = 1.0
                    }
                }, completion: { (finished) in
                    self.highlightedComponent = isPlus ? VerticalStepperComponents.plus : VerticalStepperComponents.minus
                })
            }
        } else {
            if let touchedBefore = self.highlightedComponent{
                let wasPlus = touchedBefore == .minus
                
                UIView.animate(withDuration: kDuration, delay: 0.0, options: .curveEaseInOut, animations: {
                    if wasPlus {
                        self.plusShade.alpha  = 0.0
                    } else {
                        self.minusShade.alpha = 0.0
                    }
                }, completion: { (finished) in
                    self.highlightedComponent = nil
                })
            } else {
                //do nothing
                return true
            }
        }
        
        return touchedNow != nil
    }
    
    internal func deHighlightAsNeeded(){
        UIView.animate(withDuration: kDuration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.plusShade.alpha  = 0.0
            self.minusShade.alpha = 0.0
        }, completion: { (finished) in
            self.highlightedComponent = nil
        })
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setStrokeColor(lineColor)
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.setLineWidth(lineThickness)
        
        let insetRect = rect.insetBy(dx: lineThickness, dy: lineThickness)
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: self.cornerRadius)
        path.stroke()
        path.fill(with: CGBlendMode.color, alpha: 0.5)
    }
    
    
}

@IBDesignable class Minus: UIView {
    
    var lineColor        = UIColor(r: 122, g: 122, b: 122).cgColor
    var buttonScale      = CGFloat(0.5)
    var lineThickness    = CGFloat(2.0)
    
    internal func minHalfLength(_ rect: CGRect) -> CGFloat {
        return min(rect.width * buttonScale, rect.height * buttonScale)/2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(){
        super.init(frame: CGRect.zero)
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setStrokeColor(lineColor)
        ctx.setLineWidth(lineThickness)
        
        let x = minHalfLength(rect)
        let t = lineThickness/2.0
        
        let a = CGPoint(x: rect.midX - x, y: rect.midY - t)
        let b = CGPoint(x: rect.midX + x, y: rect.midY - t)
        
        ctx.strokeLineSegments(between: [a,b])
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
    
}

@IBDesignable class Plus: Minus {
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setStrokeColor(lineColor)
        ctx.setLineWidth(lineThickness)
        
        let x = minHalfLength(rect)
        let t = lineThickness/2.0
        
        let a = CGPoint(x: rect.midX - x, y: rect.midY - t)
        let b = CGPoint(x: rect.midX + x, y: rect.midY - t)
        let c = CGPoint(x: rect.midX, y: rect.midY - x)
        let d = CGPoint(x: rect.midX, y: rect.midY + x)
        
        ctx.strokeLineSegments(between: [a,b])
        ctx.strokeLineSegments(between: [c,d])
    }
    
}

@IBDesignable class JustALine: UIView {
    
    var lineColor        = UIColor(r: 122, g: 122, b: 122).cgColor
    var lineThickness    = CGFloat(1.0)
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setStrokeColor(lineColor)
        ctx.setLineWidth(lineThickness)
        
        let t  = lineThickness/2.0
        let t2 = lineThickness
        let a  = CGPoint(x: rect.minX + t2, y: rect.midY - t)
        let b  = CGPoint(x: rect.maxX - t2, y: rect.midY - t)
        
        ctx.strokeLineSegments(between: [a,b])
    }
    
}
