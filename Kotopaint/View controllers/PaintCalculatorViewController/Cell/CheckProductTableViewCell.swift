//
//  CheckProductTableViewCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

protocol CheckProductTableViewCellDelegate {
    func checkProduct(product: Product, checked: Bool)
}

class CheckProductTableViewCell: UITableViewCell, ReusableView {

    // Properties
    var data = Product()
    var delegate: CheckProductTableViewCellDelegate?
    
    // Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var checkBox: CheckBoxButton!
    
    // Methods
    func configure(data: Product) {
        self.data = data
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        if let firstUrl = data.imageUrls.first {
            thumbnailImageView.kf.setImage(with: firstUrl, placeholder: #imageLiteral(resourceName: "no-image"), options: [.transition(.fade(0.2))])
        }
        else {
            thumbnailImageView.image = #imageLiteral(resourceName: "no-image")
        }
        
        checkBox.object = data
        checkBox.checkedImage = #imageLiteral(resourceName: "checked_radio")
        checkBox.uncheckedImage = #imageLiteral(resourceName: "unchecked_radio")
        checkBox.image = #imageLiteral(resourceName: "unchecked_radio")
        checkBox.delegate = self
    }
    
    func setupView() {
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
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

extension CheckProductTableViewCell: CheckBoxButtonDelegate {
    func checkBoxDidChange(checkBox: CheckBoxButton, value: Bool, object: Any?) {
        if let product = object as? Product {
            delegate?.checkProduct(product: product, checked: value)
        }
    }
}
