//
//  ImageModel.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/5/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class ImageModel {
    
    var index = 0
    var image = UIImage()
    
    init() {
        
    }
    
    init(index: Int, image: UIImage) {
        self.index = index
        self.image = image
    }
}
