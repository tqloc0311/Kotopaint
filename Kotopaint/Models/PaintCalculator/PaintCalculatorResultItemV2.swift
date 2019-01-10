//
//  PaintCalculatorResultItemV2.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 1/10/19.
//  Copyright © 2019 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class PaintCalculatorResultItemV2 {
    
    // Properties
    var id = 0
    var title = ""
    var excerpt = ""
    var imageURLString = ""
    var imageURL: URL? {
        return URL(string: imageURLString)
    }
    var dungtich1 = 0
    var dungtich2 = 0
    var dophu = 0
    var type1 = 0
    var type2 = 0
    var donvi = ""
    var solop = 0
    var tinhtoan = ""
    var acreage = 0
    var sum = 0
    
    //
    init() {
        
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        excerpt = json["excerpt"].stringValue
        imageURLString = json["image"].stringValue
        dungtich1 = json["dungtich1"].intValue
        dungtich2 = json["dungtich2"].intValue
        dophu = json["dophu"].intValue
        type1 = json["type1"].intValue
        type2 = json["type2"].intValue
        donvi = json["donvi"].stringValue
        solop = Int(json["solop"].stringValue) ?? 0
        tinhtoan = json["tinhtoan"].stringValue
        acreage = json["acreage"].intValue
        sum = json["sum"].intValue
    }
}
