//
//  ScreenshotHelper.swift
//  FineDust
//
//  Created by YangJehPark on 27/01/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import UIKit

class ScreenshotHelper {
    
    static func takeScreenshot(tagetView: UIView?, _ shouldSave: Bool = true) -> UIImage? {
        var screenshotImage: UIImage?
        var layer: CALayer
        if let targetLayer = tagetView?.layer {
            layer = targetLayer
        } else {
            layer = UIApplication.shared.keyWindow!.layer
        }
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, UIScreen.main.scale);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        return screenshotImage
    }
}
