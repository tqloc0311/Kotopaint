//
//  CheckProductTableViewCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

protocol CheckProductTableViewCellDelegate {
    func selectProduct(product: Product)
}

class CheckProductTableViewCell: UITableViewCell, ReusableView {

    // Properties
    var data = Product()
    var delegate: CheckProductTableViewCellDelegate?
    var checked = false {
        didSet {
            checkBox.image = checked ? #imageLiteral(resourceName: "checked_radio") : #imageLiteral(resourceName: "unchecked_radio")
        }
    }
    
    // Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var checkBox: ImageButton!
    
    // Methods
    func configure(data: Product) {
        self.data = data
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        if let firstURL = data.imageURLs.first {
            thumbnailImageView.kf.setImage(with: firstURL, placeholder: #imageLiteral(resourceName: "no-image"), options: [.transition(.fade(0.2))])
        }
        else {
            thumbnailImageView.image = #imageLiteral(resourceName: "no-image")
        }
        
        checkBox.touchUpInsideAction = { [unowned self] in
            self.delegate?.selectProduct(product: data)
        }
    }
    
    func setupView() {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }
    
    // Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        checked = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }
}
