//
//  Category.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/8/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category {
    
    // MARK: Properties
    var id = 0
    var title = ""
    var subTitle = ""
    var order = 0
    var imageUrl: URL?
    var parentId = 0
    var child = [Category]()
    
    // MARK: Constructors
    init() {
        
    }
    
    init?(json: JSON) {
        guard
            let id = json["id"].int,
            let title = json["name"].string,
            let subTitle = json["sub_title"].string,
            let order = json["order"].int,
            let imageUrlString = json["image"].string,
            let parentId = json["parent_id"].int,
            let publicValue = json["public"].int
        else {
            return nil
        }
        
        if publicValue == 0 {
            return nil
        }
        
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.order = order
        self.parentId = parentId
        self.imageUrl = URL(string: imageUrlString)
    }
}
