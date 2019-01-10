//
//  PaintCalculatorProduct.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 1/10/19.
//  Copyright © 2019 Stage Group. All rights reserved.
//

import SwiftyJSON

class PaintCalculatorProduct {
    
    // Properties
    var id = 0
    var name = ""
    var categoryID = 0
    var numOfLayers = 0
    
    // Constructors
    init(categoryID: Int, json: JSON) {
        self.categoryID = categoryID
        self.id = json["product_id"].intValue
        self.name = json["product_name"].stringValue
    }
}
