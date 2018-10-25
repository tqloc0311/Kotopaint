
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

class Product: Hashable {
    
    // MARK: Properties
    var id = 0
    var order = 0
    var title = ""
    var subTitle = ""
    var content = ""
    var notePrice = ""
    var huongdan = ""
    var excerpt = ""
    var price = 0
    var salePrice = 0
    var imageURLs = [URL]()
    var capacity1 = 0
    var capacity2 = 0
    var donvi = ""
    var isPublic = true
    var dungtich1 = 0
    var dungtich2 = 0
    var categoryId = 0
    
    // MARK: Hashable
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    var hashValue: Int {
        return id
    }
    
    // MARK: Constructors
    init() {
        
    }
    
    init?(json: JSON) {
        guard
            let id = json["id"].int,
            let order = json["order"].int,
            let title = json["title"].string,
            let subTitle = json["sub_title"].string,
            let content = json["content"].string,
            let notePrice = json["noteprice"].string,
            let huongdan = json["huongdan"].string,
            let excerpt = json["excerpt"].string,
            let price = json["price"].int,
            let salePrice = json["price_sale"].int,
            let imageURL1 = json["image"].string,
            let imageURL2 = json["image2"].string,
            let imageURL3 = json["image3"].string,
            let imageURL4 = json["image4"].string,
            let isPublicValue = json["public"].int,
            let dungtich1 = json["dungtich1"].int,
            let dungtich2 = json["dungtich2"].int,
            let donvi = json["donvi"].string
            else {
                return nil
        }
        
        self.id = id
        self.categoryId = json["category_id"].intValue
        self.title = title
        self.subTitle = subTitle
        self.content = content
        self.notePrice = notePrice
        self.huongdan = huongdan
        self.excerpt = excerpt
        self.price = price
        self.salePrice = salePrice
        self.imageURLs = [imageURL1, imageURL2, imageURL3, imageURL4].compactMap({ URL(string: $0) })
        self.isPublic = isPublicValue == 1
        self.dungtich1 = dungtich1
        self.dungtich2 = dungtich2
        self.donvi = donvi
        self.order = order
    }
}
