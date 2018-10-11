//
//  MenuContentView.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/15/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit

class MenuContentView: UIView {
    
    // Properties
    var data = MenuContent()
    
    // Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
//    @IBOutlet weak var lblTitleHeight: NSLayoutConstraint!
    
    // Methods
    func configure(_ data: MenuContent) {
        self.data = data
        imageView.image = data.image
        imageView.heroID = data.imageHeroID
        
        if data.title == "" {
            lblTitle.isHidden = true
            lblTitle.heroID = ""
//            lblTitleHeight.constant = 0
            
//            imageView.layer.shadowColor = UIColor.gray.cgColor
//            imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
//            imageView.layer.shadowOpacity = 0.7
//            imageView.layer.shadowRadius = 4.0
            
            backgroundColor = .clear
        }
        else {
            lblTitle.isHidden = false
            lblTitle.text = data.title
            lblTitle.heroID = data.titleHeroID
//            lblTitleHeight.constant = 30
            
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 3, height: 3)
            layer.shadowOpacity = 0.7
            layer.shadowRadius = 4.0
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
