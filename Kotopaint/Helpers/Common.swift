//
//  Common.swift
//  Chat Novel
//
//  Created by Tran Quoc Loc on 12/19/17.
//  Copyright © 2017 Tom Company. All rights reserved.
//

import Foundation
import UIKit
import Fakery
import Alamofire
import AlamofireImage

let GOOGLE_MAPS_SDK_KEY = "AIzaSyC9KLiqiz8iGOZIhuG8EOJBn8q0RHwIySQ"
let DEFAULT_COLOR: UIColor = (0x242582).toUIColor()
let TAB_BAR_TEXT_COLOR: UIColor = (0x7F7F7F).toUIColor()
let TAB_BAR_SELECTED_TEXT_COLOR: UIColor = (0x383B94).toUIColor()
let IMAGE_RATIO: CGFloat = 3/4

func executeOnBackground(task: @escaping ()->(), completion: @escaping ()->(), delay: TimeInterval = 3) {
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + delay) {
        task()
        DispatchQueue.main.async {
            completion()
        }
    }
}

