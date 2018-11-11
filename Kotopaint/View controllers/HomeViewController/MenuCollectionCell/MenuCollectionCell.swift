//
//  MenuCollectionCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/15/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit
import Fakery

class MenuCollectionCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Properties
    var data = HomeMenuItem()
    var shadow = true
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var bottomTitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainView: ViewButton!
    
    // MARK: - Methods
    func configure(_ data: HomeMenuItem) {
        self.data = data
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
//        titleLabel.hero.id = data.titleHeroID
        imageView.image = data.photo
        bottomTitleLabel.text = data.bottomTitle
        self.shadow = data.shadow
    }

    // Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadow {
            imageView.layer.shadowColor = UIColor.gray.cgColor
            imageView.layer.shadowOffset = CGSize(width: 3, height: 3)
            imageView.layer.shadowOpacity = 0.7
            imageView.layer.shadowRadius = 4.0
        }
        else {
            imageView.layer.shadowColor = UIColor.clear.cgColor
        }
    }
}
