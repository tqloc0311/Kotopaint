//
//  Globals.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/11/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class Globals {
    
    static var NOITHAT_CATEGORY_ID = 29
    static var NGOAITHAT_CATEGORY_ID = 30
    
    static func downloadImage(url: String, handler: @escaping (UIImage?)->()) {
        if url == "" {
            handler(nil)
        }
        
        Alamofire.request(url).responseImage { response in
            handler(response.result.value)
        }
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
}
