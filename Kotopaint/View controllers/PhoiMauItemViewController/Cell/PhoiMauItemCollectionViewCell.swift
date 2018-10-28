//
//  PhoiMauItemCollectionViewCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/26/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PhoiMauItemCollectionViewCell: UICollectionViewCell, ReusableView {
    
    var panAction: ((Bool)->())?
    var selectAction: (()->())?
    
    var data: PhoiMauItem!
    
    @IBOutlet weak var imageView: ImageButton!
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if recognizer.state != .ended {
            return
        }
        if let f = panAction, let isRight = recognizer.isLeftToRight(self) {
            f(isRight)
        }
    }
    
    func configure(_ data: PhoiMauItem) {
        self.data = data
        imageView.kf.setImage(with: data.imageURL, placeholder: #imageLiteral(resourceName: "no-image"), options: [.transition(.fade(0.2))])
        
        imageView.touchUpInsideAction = { [weak self] in
            guard let self = self else { return }
            if let f = self.selectAction {
                f()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        panGesture.delegate = self
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
    }
}

extension PhoiMauItemCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
