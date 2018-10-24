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
    var imageUrl: URL?
    var colorItems = [ColorItem]()
    
    // Constructors
    init?(json: JSON) {
        guard
            let id = json["id"].int,
            let title = json["title"].string,
            let image = json["image"].string,
            let url = URL(string: "https://kotopaint.vn/uploads/source/" + image),
            let color = json["color"].string
            else {
                return nil
        }
        
        let colorJSON = JSON.init(parseJSON: color.replacingOccurrences(of: "\\", with: ""))
        
        if colorJSON == JSON.null {
            return nil
        }
        
        self.id = id
        self.title = title
        self.imageUrl = url
        self.colorItems = colorJSON.dictionaryValue.compactMap({ ColorItem(id: $0.key, json: $0.value) })
    }
}
