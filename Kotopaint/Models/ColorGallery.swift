//
//  ColorGallery.swift
//  
//
//  Created by Tran Quoc Loc on 10/24/18.
//

import Foundation
import SwiftyJSON

class ColorGallery {
    
    // Properties
    var id = 0
    var title = ""
    var imageURL: URL?
    var colorItems = [ColorItem]()
    
    // Constructors
    init?(json: JSON) {
        guard
            let id = json["id"].int,
            let title = json["title"].string,
            let image = json["image"].string,
            let url = URL(string: image),
            json["color"] != JSON.null
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.imageURL = url
        self.colorItems = json["color"].dictionaryValue.compactMap({ ColorItem(id: $0.key, json: $0.value) })
    }
}
