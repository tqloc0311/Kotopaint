
//
//  News.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/16/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class News {
    
    // Properties
    var id = 0
    var name = ""
    var shortContent = ""
    var content = ""
    var image: UIImage?
    var imageUrl = ""
    
    // Constructors
    init() {
        
    }
    
    init(id: Int, name: String, shortContent: String, content: String, imageUrl: String, image: UIImage? = nil) {
        self.id = id
        self.name = name
        self.shortContent = shortContent
        self.content = content
        self.imageUrl = imageUrl
        self.image = image
    }
}
