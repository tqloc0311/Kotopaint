//
//  PaintCalculatorResultItem.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class PaintCalculatorResultItem {
    
    // Properties
    var id = 0
    var title = ""
    var excerpt = ""
    var imageURL: URL?
    var dungtich1 = 0
    var dungtich2 = 0
    var type1 = 0
    var type2 = 0
    var donvi = ""
    var categoryTitle = ""
    var categoryID = 0
    
    //
    init() {
        
    }
    
    init?(json: JSON) {
        guard
            let id = json["id"].int,
            let title = json["title"].string,
            let excerpt = json["excerpt"].string,
            let imageURL = json["image"].string,
            let dungtich1 = json["dungtich1"].int,
            let dungtich2 = json["dungtich2"].int,
            let type1 = json["type1"].int,
            let type2 = json["type2"].int,
            let donvi = json["donvi"].string,
            let categoryTitle = json["categories_title"].string,
            let categoryID = json["categories_id"].int
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.excerpt = excerpt
        self.imageURL = URL(string: imageURL)
        self.dungtich1 = dungtich1
        self.dungtich2 = dungtich2
        self.type1 = type1
        self.type2 = type2
        self.donvi = donvi
        self.categoryTitle = categoryTitle
        self.categoryID = categoryID
    }
}
