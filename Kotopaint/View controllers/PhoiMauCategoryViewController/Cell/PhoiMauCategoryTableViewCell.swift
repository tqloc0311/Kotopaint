//
//  PhoiMauCategoryTableViewCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/26/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PhoiMauCategoryTableViewCell: UITableViewCell, ReusableView {

    // MARK: - Properties
    var data = PhoiMauCategory()
    var selectAction: (()->())?
    var panAction: ((Bool)->())?
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Methods
    
    func configure(data: PhoiMauCategory) {
        self.data = data
        titleLabel.text = data.name
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
