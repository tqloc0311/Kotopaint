//
//  Category.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/8/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import SwiftyJSON

class Category: Hashable {
    
    
    // MARK: Properties
    var id = 0
    var title = ""
    var subTitle = ""
    var order = 0
    var imageURL: URL?
    var parentID = 0
    var child = [Category]()
    
    // MARK: Hashable
    static func == (lhs: Category, rhs: Category) -> Bool {
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
            let title = json["name"].string,
            let subTitle = json["sub_title"].string,
            let order = json["order"].int,
            let imageURLString = json["image"].string,
            let parentID = json["parent_id"].int,
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
        self.parentID = parentID
        self.imageURL = URL(string: imageURLString)
    }
}
