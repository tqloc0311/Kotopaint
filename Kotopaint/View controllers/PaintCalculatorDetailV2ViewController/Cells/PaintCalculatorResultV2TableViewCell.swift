//
//  PaintCalculatorResultV2TableViewCell.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 1/11/19.
//  Copyright © 2019 Stage Group. All rights reserved.
//

import UIKit

class PaintCalculatorResultV2TableViewCell: UITableViewCell, ReusableView {
    
    // Properties
    var data: PaintCalculatorResultItemV2!
    
    // Outlets
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.setBorder(color: .clear, width: 0, corner: 10)
        }
    }
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var dophuLabel: UILabel!
    @IBOutlet weak var layerLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountCaption1Label: UILabel!
    @IBOutlet weak var amountDetail1Label: UILabel!
    @IBOutlet weak var amountCaption2Label: UILabel!
    @IBOutlet weak var amountDetail2Label: UILabel!
    
    // Methods
    func configure(data: PaintCalculatorResultItemV2) {
        self.data = data
        titleLabel.text = data.title
        thumbnailImageView.kf.setImage(with: data.imageURL, placeholder: #imageLiteral(resourceName: "no-image"), options: [.transition(.fade(0.2))])
        areaLabel.text = "\(data.acreage)m²"
        dophuLabel.text = "\(data.dophu)m²/kg"
        layerLabel.text = "\(data.solop)"
        amountLabel.text = "\(data.sum) \(data.donvi)"
        
        if data.type1 > 0 && data.type2 > 0 {
            amountCaption1Label.text = "Số \(data.tinhtoan) sơn: "
            amountDetail1Label.text = "\(data.type1) \(data.tinhtoan) \(data.dungtich2) \(data.donvi)"
            
            amountCaption2Label.text = "Số \(data.tinhtoan) sơn: "
            amountDetail2Label.text = "\(data.type2) \(data.tinhtoan) \(data.dungtich1) \(data.donvi)"
        }
        else if data.type1 > 0 && data.type2 > 0 {
            amountCaption1Label.isHidden = true
            amountDetail1Label.isHidden = true
            amountCaption2Label.isHidden = true
            amountDetail2Label.isHidden = true
        }
        else {
            amountCaption2Label.isHidden = true
            amountDetail2Label.isHidden = true
            
            if data.type1 > 0 {
                amountCaption1Label.text = "Số \(data.tinhtoan) sơn: "
                amountDetail1Label.text = "\(data.type1) \(data.tinhtoan) \(data.dungtich2) \(data.donvi)"
            }
            else {
                amountCaption1Label.text = "Số \(data.tinhtoan) sơn: "
                amountDetail1Label.text = "\(data.type2) \(data.tinhtoan) \(data.dungtich1) \(data.donvi)"
            }
        }
    }
    
    // Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }
}
