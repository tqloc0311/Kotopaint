//
//  PhoiMauItemCollectionViewCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/26/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

protocol PhoiMauItemCollectionViewCellDelegate: class {
    func phoiMauItemCollectionViewCellDidSelect(_ cell: PhoiMauItemCollectionViewCell, data: PhoiMauItem)
    func phoiMauItemCollectionViewCellDidPan(_ cell: PhoiMauItemCollectionViewCell, data: PhoiMauItem, isRight: Bool)
}

class PhoiMauItemCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private var data: PhoiMauItem!
    
    weak var delegate: PhoiMauItemCollectionViewCellDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if recognizer.state != .ended {
            return
        }
        if let isRight = recognizer.isLeftToRight(self) {
            delegate?.phoiMauItemCollectionViewCellDidPan(self, data: data, isRight: isRight)
        }
    }
    
    func configure(_ data: PhoiMauItem) {
        self.data = data
        imageView.kf.setImage(with: data.imageURL, placeholder: #imageLiteral(resourceName: "no-image"), options: [.transition(.fade(0.2))])
        
//        imageView.touchUpInsideAction = { [weak self] in
//            guard let self = self else { return }
//            self.delegate?.phoiMauItemCollectionViewCellDidSelect(self, data: self.data)
//        }
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
