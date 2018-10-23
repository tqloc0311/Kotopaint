//
//  CategoryCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/8/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AllCategoryCell: UITableViewCell, ReusableView {

    // MARK: - Properties
    var data = Category()
    var selectAction: (()->())?
    var panAction: ((Bool)->())?
    
    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var highlightView: UIView!
    
    // MARK: - Methods
    func select() {
        if let f = selectAction {
            f()
        }
    }
    
    func highlight(_ bool: Bool) {
        highlightView.isHidden = !bool
    }
    
    // Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.setBorder(color: .clear, width: 1, corner: 10)
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        
        let panGesture = UIPanGestureRecognizer { (gesture) in
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
