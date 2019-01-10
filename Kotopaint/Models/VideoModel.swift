//
//  VideoModel.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/6/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import SwiftyJSON

class VideoModel {
    
    // MARK: - Properties
    var id = 0
    var videoURLString = ""
    var videoURL: URL? {
        return URL(string: videoURLString)
    }
    var title = ""
    var thumbnailURLString = ""
    var thumbnailURL: URL? {
        return URL(string: thumbnailURLString)
    }
    
    // Constructor
    init() {
        
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        videoURLString = json["video"].stringValue
        thumbnailURLString = json["image"].stringValue
    }
}
