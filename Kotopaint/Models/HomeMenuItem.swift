//
//  HomeMenuItem.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/15/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class HomeMenuItem {
    // MARK: - Properties
    var id = 0
    var title = ""
    var subTitle = ""
    var photo = UIImage()
    var titleHeroID = ""
    var shadow = true
    var bottomTitle = ""
    
    // Constructors
    init() {
        
    }
    
    init(id: Int, title: String, titleHeroID: String, subTitle: String, photo: UIImage, bottomTitle: String = "") {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.photo = photo
        self.titleHeroID = titleHeroID
        self.bottomTitle = bottomTitle
    }
}
