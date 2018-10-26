//
//  CheckProductTableViewCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PaintCalculatorResultTableViewCell: UITableViewCell, ReusableView {

    // Properties
    var data = PaintCalculatorResultItem()
    
    // Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var dungtich1Label: UILabel!
    @IBOutlet weak var dungtich2Label: UILabel!
    
    // Methods
    func configure(data: PaintCalculatorResultItem) {
        self.data = data
        titleLabel.text = data.title
        subTitleLabel.text = data.excerpt.html().string
        thumbnailImageView.kf.setImage(with: data.imageURL, placeholder: #imageLiteral(resourceName: "no-image"), options: [.transition(.fade(0.2))])
        
        if data.type1 == 0 || data.type2 == 0 {
            dungtich2Label.isHidden = true
            if data.type1 == 0 {
                dungtich1Label.text = "\(data.type2) (\(data.dungtich2) \(data.donvi))"
            }
            else {
                dungtich1Label.text = "\(data.type1) (\(data.dungtich1) \(data.donvi))"
            }
        }
        else if data.type1 == 0 && data.type2 == 0 {
            dungtich1Label.isHidden = true
            dungtich2Label.isHidden = true
        }
        else {
            dungtich1Label.text = "\(data.type1) (\(data.dungtich1) \(data.donvi))"
            dungtich2Label.text = "\(data.type2) (\(data.dungtich2) \(data.donvi))"
        }
    }
    
    func setupView() {
        containerView.setBorder(color: .clear, width: 0, corner: 10)
        dungtich1Label.setBorder(color: .clear, width: 0, corner: 4)
        dungtich2Label.setBorder(color: .clear, width: 0, corner: 4)
    }
    
    // Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }
}
