//
//  CategoryCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/8/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Kingfisher
import ActionKit

class CategoryCell: UITableViewCell, ReusableView {
    
    enum CategoryImageStyle {
        case thumbnail
        case background
    }

    // MARK: - Properties
    var data = Category()
    var selectAction: (()->())?
    var panAction: ((Bool)->())?
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    // MARK: - Methods
    
    func configure(data: Category, style: CategoryImageStyle = .thumbnail) {
        self.data = data
        
        switch style {
        case .thumbnail:
            thumbnailImageView.kf.setImage(with: data.imageURL, placeholder: #imageLiteral(resourceName: "no-image"), options: [.transition(.fade(0.2))])
            backgroundImageView.image = nil
        case .background:
            backgroundImageView.kf.setImage(with: data.imageURL, placeholder: UIImage(), options: [.transition(.fade(0.2))])
            thumbnailImageView.image = nil
        }
        
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
    }
    
    func select() {
        if let f = selectAction {
            f()
        }
    }
    
    func highlight(_ bool: Bool) {
        containerView.alpha = bool ? 0.5 : 1
    }
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if let f = panAction, let isRight = recognizer.isLeftToRight(self) {
            f(isRight)
        }
    }
    
    // Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.setBorder(color: .clear, width: 1, corner: 10)
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        
        let panGesture = UIPanGestureRecognizer { [weak self] (gesture) in
            guard let self = self else { return }
            if gesture.state != .ended {
                return
            }
            if let panGesture = gesture as? UIPanGestureRecognizer, let f = self.panAction, let isRight = panGesture.isLeftToRight(self) {
                f(isRight)
            }
        }
        panGesture.delegate = self
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
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
