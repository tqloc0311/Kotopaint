//
//  PaintCalculatorCategory.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 1/10/19.
//  Copyright © 2019 Stage Group. All rights reserved.
//

import SwiftyJSON

class PaintCalculatorCategory {
    
    // Properties
    var id = 0
    var name = ""
    var products: [PaintCalculatorProduct] = []
    
    // Constructors
    init(json: JSON) {
        self.id = json["categories"].intValue
        self.name = json["category_name"].stringValue
        products = json["category_product"].arrayValue.compactMap({ PaintCalculatorProduct(categoryID: id, json: $0) })
    }
}
