//
//  ColorGalleryCollectionViewCell.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/24/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class ColorGalleryCollectionViewCell: UICollectionViewCell, ReusableView {
    
    // Properties
    var data: ColorGallery!
    var selectAction: (()->())?
    
    // Outlets
    @IBOutlet weak var colorImageView: ImageButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Methods
    func configure(_ data: ColorGallery) {
        self.data = data
        self.colorImageView.kf.setImage(with: data.imageURL)
        self.titleLabel.text = data.title
        
        colorImageView.touchUpInsideAction = { [weak self] in
            guard let self = self else { return }
            if let f = self.selectAction {
                f()
            }
        }
    }
    
    private func setupView() {
        colorImageView.roundCorners([.topRight, .bottomLeft], radius: 12)
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        setupView()
    }
}
