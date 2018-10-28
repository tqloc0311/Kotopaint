//
//  UIImage.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/27/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
