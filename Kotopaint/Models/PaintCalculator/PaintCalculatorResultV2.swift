//
//  PaintCalculatorResultV2.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 1/10/19.
//  Copyright © 2019 Stage Group. All rights reserved.
//

import SwiftyJSON

class PaintCalculatorResultV2 {
    
    //
    var acreageEx = 0
    var acreageWater = 0
    var acreageFu = 0
    var acreageFul = 0
    var acreageCe = 0
    
    var items = [PaintCalculatorResultItemV2]()
    
    //
    init() {
        
    }
    
    init(json: JSON) {
        acreageEx = json["acreage_ex"].intValue
        acreageWater = json["acreage_water"].intValue
        acreageFu = json["acreage_fu"].intValue
        acreageFul = json["acreage_ful"].intValue
        acreageCe = json["acreage_ce"].intValue
        items = json["data"].arrayValue.compactMap({ PaintCalculatorResultItemV2(json: $0) })
    }
}
