//
//  MenuContent.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/15/18.
//  Copyright © 2018 FREELANCE. All rights reserved.

import Foundation

class MenuContent {
    
    // MARK: - Properties
    var id = 0
    var title = ""
    var image = UIImage()
    var titleHeroID = ""
    var imageHeroID = ""
    var selfHeroID = ""
    
    // MARK: - Methods
    func getView(width: CGFloat, height: CGFloat) -> MenuContentView {
        return getView(x: 0, y: 0, width: width, height: height)
    }
    
    func getView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> MenuContentView {
        let view = UIView.loadFromNibNamed("MenuContentView") as! MenuContentView
        view.frame = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height))
        view.configure(self)
        return view
    }
    
    // Constructors
    init() {
        
    }
    
    init(id: Int, title: String, titleHeroID: String, image: UIImage, imageHeroID: String) {
        self.id = id
        self.title = title
        self.image = image
        self.titleHeroID = titleHeroID
        self.imageHeroID = imageHeroID
    }
}
