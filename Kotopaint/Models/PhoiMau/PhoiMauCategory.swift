//
//  PhoiMauCategory.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/26/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhoiMauCategory {
    
    //
    var id = 0
    var name = ""
    var parentID = 0
    var child = [PhoiMauCategory]()
    
    //
    init() {
        
    }
    
    init?(json: JSON) {
        guard
        let id = json["id"].int,
        let name = json["name"].string,
        let parentID = json["parent_id"].int
            else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.parentID = parentID
    }
}
