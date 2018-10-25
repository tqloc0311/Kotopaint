//
//  PaintCalculatorResult.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class PaintCalculatorResult {
    
    //
    var area = 0
    var construct = ""
    var items = [PaintCalculatorResultItem]()
    
    //
    init() {
        
    }
    
    init(json: JSON) {
        area = json["acreage"].intValue
        construct = json["construct"].stringValue
        items = json["data"].dictionaryValue.compactMap({ PaintCalculatorResultItem(json: $0.value) })
    }
}
