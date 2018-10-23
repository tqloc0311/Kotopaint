//
//  VideoModel.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/6/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class VideoModel {
    
    // MARK: - Properties
    var id = 0
    var url = ""
    var title = ""
    var thumbnail: UIImage?
    
    // Constructor
    init() {
        
    }
    
    init(id: Int, url: String, title: String, image: UIImage? = nil) {
        self.id = id
        self.url = url
        self.title = title
        self.thumbnail = image
    }
}
