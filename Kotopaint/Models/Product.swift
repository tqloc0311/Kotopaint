
//
//  Product.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/4/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import Fakery
import SwiftyJSON

class Product {
    
    // MARK: Properties
    var id = 0
    var order = 0
    var title = ""
    var subTitle = ""
    var content = ""
    var notePrice = ""
    var guide = ""
    var excerpt = ""
    var price = 0
    var salePrice = 0
    var imageUrls = [String]()
    var capacity1 = 0
    var capacity2 = 0
    var unit = ""
    
    // MARK: Constructors
    init() {
        
    }
    
    init?(json: JSON) {
        guard
            let id = json["id"].int,
            let order = json["order"].int,
            let title = json["name"].string,
            let subTitle = json["sub_title"].string,
            let content = json["content"].string,
            let imageUrl = json["image"].string,
            let parentId = json["parent_id"].int,
            let publicValue = json["public"].int
            else {
                return nil
        }
    }
}
