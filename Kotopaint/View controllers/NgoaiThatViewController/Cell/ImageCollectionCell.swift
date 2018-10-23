//
//  ImageCollectionCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/5/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell, ReusableView {
    
    var panAction: ((Bool)->())?
    
    var data = ImageModel()
    
    @IBOutlet weak var imgvPhoto: ImageButton!
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if let f = panAction, let isRight = recognizer.isLeftToRight(self) {
            f(isRight)
        }
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

extension ImageCollectionCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
