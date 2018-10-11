//
//  FaqItem.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/9/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class FaqItem {
    
    // Properties
    var id = 0
    var title = ""
    var content = ""
    
    // Constructors
    init() {
        
    }
    
    init(id: Int, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
