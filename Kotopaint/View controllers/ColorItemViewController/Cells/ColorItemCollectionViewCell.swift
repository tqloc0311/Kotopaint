//
//  ColorItemCollectionViewCell.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/24/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class ColorItemCollectionViewCell: UICollectionViewCell, ReusableView {
    
    // Properties
    var data: ColorItem!
    
    // Outlets
    @IBOutlet weak var colorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Methods
    func configure(_ data: ColorItem) {
        self.data = data
        self.colorImageView.backgroundColor = data.color
        self.colorImageView.hero.id = "colorItemDetail_\(data.id)"
        self.titleLabel.text = data.name
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
