//
//  ScreenshotHelper.swift
//  FineDust
//
//  Created by YangJehPark on 27/01/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit
import GIFGenerator

class ScreenshotHelper {
    
    /// synchronous
    static func takeScreenshot(targetView: UIView?) -> UIImage? {
        var screenshotImage: UIImage?
        var layer: CALayer
        if let targetLayer = targetView?.layer {
            layer = targetLayer
        } else {
            layer = UIApplication.shared.keyWindow!.layer
        }
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, UIScreen.main.scale);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    /// asynchronous
    static func takeScreenshot(targetView: UIView?, completionHandler: @escaping (_ image: UIImage?) -> Void) {
        var screenshotImage: UIImage?
        var layer: CALayer
        if let targetLayer = targetView?.layer {
            layer = targetLayer
        } else {
            layer = UIApplication.shared.keyWindow!.layer
        }
        DispatchQueue.main.async {
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, UIScreen.main.scale);
            guard let context = UIGraphicsGetCurrentContext() else {
                completionHandler(nil)
                return
            }
            layer.render(in:context)
            screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            completionHandler(screenshotImage)
        }
    }
    
    private static var gifDestinationURL: URL {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return URL(fileURLWithPath: documentsPath + "/imageAnimated.gif")
    }
    
    static func takeGIF(targetView: UIView, completionHandler: @escaping (_ gifURL: URL?) -> Void) {
        var screenshotArray = [UIImage]()
        let blinker = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
            if let result = takeScreenshot(targetView: targetView) {
                screenshotArray.append(result)
            }
        }
        blinker.fire()
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer:Timer) in
            blinker.invalidate()
            GifGenerator().generateGifFromImages(imagesArray: screenshotArray, frameDelay: 0.25, destinationURL: gifDestinationURL, callback: { (data:Data?, error:NSError?) in
                if data != nil, error == nil {
                    completionHandler(gifDestinationURL)
                } else {
                    completionHandler(nil)
                }
            })
        }
    }
    
    static func cleanGIF() {
        do {
            try FileManager.default.removeItem(at: gifDestinationURL)
            log("cleanGIF success")
        } catch {
            log("cleanGIF fail")
        }
    }
}
