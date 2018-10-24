//
//  ColorItem.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/24/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class ColorItem {
    
    // Properties
    var id = ""
    var name = ""
    var color: UIColor!
    
    // Constructors
    init(id: String, name: String, color: UIColor) {
        self.id = id
        self.name = name
        self.color = color
    }
    
    init?(id: String, json: JSON) {
        guard let name = json["name"].string, let value = json["value"].string, let color = UIColor(hexString: value) else { return nil }
        self.id = id
        self.name = name
        self.color = color
    }
}
