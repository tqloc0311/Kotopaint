//
//  PhoiMauItem.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/26/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhoiMauItem {
    
    class Hotspot {
        var x: Double = 0
        var y: Double = 0
        
        init(json: JSON) {
            x = json["x"].doubleValue
            y = json["y"].doubleValue
        }
    }
    
    class Mask {
        var hotspot: Hotspot!
        var url: URL!
        var image: UIImage?
        
        init?(json: JSON) {
            guard
                let mask = json["mask"].string,
                let url = URL(string: mask)
                else { return nil }
            hotspot = Hotspot(json: json["hotspot"])
            self.url = url
        }
    }
    
    //
    var id = 0
    var title = ""
    var imageURL: URL?
    var image: UIImage?
    var categoryID = 0
    var masks = [Mask]()
    
    //
    init() {
        
    }
    
    init?(json: JSON) {
        guard
        let id = json["id"].int,
        let title = json["title"].string,
        let image = json["image"].string,
        json["mask"].arrayValue.count > 0
            else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.imageURL = URL(string: image)
        self.masks = json["mask"].arrayValue.compactMap({ Mask(json: $0) })
        if self.masks.count == 0 {
            return nil
        }
    }
    
    //
    func download(completion: @escaping (Bool)->()) {
        let group = DispatchGroup()
        var error = false
        group.enter()
        Globals.downloadImage(url: self.imageURL?.absoluteString ?? "") { [weak self] (downloaded) in
            guard let self = self else { return }
            if let img = downloaded {
                
                self.image = img
            }
            else {
                error = true
            }
            
            group.leave()
        }
        
        for mask in masks {
            group.enter()
            Globals.downloadImage(url: mask.url?.absoluteString ?? "") { (downloaded) in
                if let img = downloaded {
                    mask.image = img
                }
                else {
                    error = true
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(!error)
        }
    }
}
