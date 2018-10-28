//
//  ProductCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/4/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell, ReusableView {
    
    // Properties
    var data = Product()
    var selectAction: (()->())?
    var panAction: ((Bool)->())?
    
    // Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
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
        
    }
    
    func highlight(_ bool: Bool) {
        containerView.alpha = bool ? 0.5 : 1
    }
    
    func select() {
        if let f = selectAction {
            f()
        }
    }
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if recognizer.state == .ended, let f = panAction, let isRight = recognizer.isLeftToRight(self) {
            f(isRight)
        }
    }
    
    // Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        panGesture.delegate = self
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlight(true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlight(false)
        select()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlight(false)
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
