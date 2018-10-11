
//
//  SideMenuItem.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/4/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class SideMenuItem {
    
    // Properties
    var id = 0
    var title = ""
    var icon = UIImage()
    
    // Constructors
    init() {
        
    }
    
    init(id: Int, title: String, icon: UIImage) {
        self.id = id
        self.title = title
        self.icon = icon
    }
}
