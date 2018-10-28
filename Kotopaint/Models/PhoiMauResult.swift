//
//  PhoiMauResult.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/28/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhoiMauResult {
    
    //
    var id = ""
    var image: UIImage?
    var selectedColorItem = [ColorItem]()
    
    //
    
    init(image: UIImage, selectedItems: [ColorItem]) {
        self.id = Globals.randomString(length: 12)
        self.image = image
        self.selectedColorItem = selectedItems
    }
    
    init?(json: JSON) {
        guard
            let id = json["id"].string,
            let imageURL = json["image"].string,
            let url = URL(string: imageURL),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)
            else { return nil }
        
        self.id = id
        self.image = image
        self.selectedColorItem = json["color_items"].dictionaryValue.compactMap({ ColorItem(id: $0.key, json: $0.value) })
        if selectedColorItem.count == 0  {
            return nil
        }
    }
}
