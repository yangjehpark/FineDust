//
//  ShareHelper.swift
//  FineDust
//
//  Created by YangJehPark on 04/02/2019.
//  Copyright © 2019 YangJehPark. All rights reserved.
//

import Foundation
import KakaoCommon
import KakaoLink
import KakaoMessageTemplate

class ShareHelper {
    
    static func shareToGIF(_ baseVC: UIViewController, gifImage: UIImage) {
        let activityItem: [AnyObject] = [gifImage]
        let aVC = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        baseVC.present(aVC, animated: true, completion: nil)
    }

    static func shareToKakaoLink(title: String, description: String, image: UIImage, completionHandler: @escaping (_ error: Error?) -> Void) {
        uploadToKakao(image: image) { (successUrl:URL?, error: Error?) in
            if let imageUrl = successUrl {
                sendKakaoLinkFeed(title: title, description: description, imageURL: imageUrl, completionHandler: { (error: Error?) in
                    if error != nil {
                        completionHandler(error)
                    } else {
                        completionHandler(nil)
                    }
                })
            } else {
                completionHandler(error)
            }
        }
    }
    
    private static func sendKakaoLinkFeed(title: String, description: String, imageURL: URL, completionHandler: @escaping (_ error: Error?) -> Void) {
        
        let template = KMTFeedTemplate { (feedTemplateBuilder) in
            feedTemplateBuilder.content = KMTContentObject(builderBlock: { (contentBuilder: KMTContentBuilder) in
                contentBuilder.title = title
                contentBuilder.desc = description
                contentBuilder.imageURL = imageURL
                contentBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                    linkBuilder.mobileWebURL = URL(string: "https://www.naver.com")
                })
            })
        }
        
        // 서버에서 콜백으로 받을 정보
        let serverCallbackArgs = ["user_id": "abcd",
                                  "product_id": "1234"]
        // 카카오링크 실행
        KLKTalkLinkCenter.shared().sendDefault(with: template, serverCallbackArgs: serverCallbackArgs, success: { (warningMsg, argumentMsg) in
            log("warning message: \(String(describing: warningMsg))")
            log("argument message: \(String(describing: argumentMsg))")
        }, failure: { (error) in
            log(error.localizedDescription)
        })
    }
    
    /// The storage hold images 20 days only
    private static func uploadToKakao(image: UIImage, completionHandler: @escaping (_ imageURL: URL?, _ error: Error?) -> Void) {
        KLKImageStorage.shared().upload(with: image, success: { (info: KLKImageInfo) in
            completionHandler(info.url, nil)
        }, failure: { (error: Error) in
            completionHandler(nil, error)
        })
    }
    
    private static func remove(url: URL) {
        KLKImageStorage.shared().delete(withImageURL: url, success: {
            log("success")
        }, failure: { (error:Error) in
            log("fail")
        })
    }
}
