//
//  PhoiMauResultTableViewCell.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/28/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PhoiMauResultTableViewCell: UITableViewCell, ReusableView {

    // Properties
    var data: PhoiMauResult!
    var panAction: ((Bool)->())?
    var selectAction: (()->())?
    
    // Outlets
    @IBOutlet weak var editedImageView: UIImageView!
    @IBOutlet var selectedColorItemImageViews: [UIImageView]!
    @IBOutlet var selectedColorItemLabels: [UILabel]!
    
    // Methods
    func configure(_ data: PhoiMauResult) {
        self.data = data
        editedImageView.image = data.image
        for (index, item) in data.selectedColorItem.enumerated() {
            if item.name == "" || item.id == "" {
                continue
            }
            selectedColorItemImageViews[index].backgroundColor = item.color
            selectedColorItemImageViews[index].isHidden = false
            selectedColorItemLabels[index].isHidden = false
            selectedColorItemLabels[index].text = item.name
        }
    }
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if recognizer.state == .ended, let f = panAction, let isRight = recognizer.isLeftToRight(self) {
            f(isRight)
        }
    }
    
    func select() {
        if let f = selectAction {
            f()
        }
    }
    
    func highlight(_ bool: Bool) {
        self.alpha = bool ? 0.5 : 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        panGesture.delegate = self
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for imgv in selectedColorItemImageViews {
            imgv.setBorder(color: .clear, width: 0, corner: imgv.bounds.height / 2)
        }
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
