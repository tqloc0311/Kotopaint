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
    
    var data: PhoiMauItem!
    
    @IBOutlet weak var imgvPhoto: ImageButton!
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if let f = panAction, let isRight = recognizer.isLeftToRight(self) {
            f(isRight)
        }
    }
    
    func configure(_ data: PhoiMauItem) {
        self.data = data
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
        
        imgvPhoto.image = data.image
    }
}

extension PhoiMauItemCollectionViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
