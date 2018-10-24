//
//  VideoCollectionCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/6/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit

class VideoCollectionCell: UICollectionViewCell, ReusableView {
    
    var data = VideoModel()
    var panAction: ((Bool)->())?
    var selectAction: (()->())?
    
    var isLoading = false {
        didSet {
            viewLoading.isHidden = !isLoading
        }
    }

    @IBOutlet weak var imgvPhoto: ImageButton!
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if recognizer.state == .ended, let f = panAction, let isRight = recognizer.isLeftToRight(self) {
            f(isRight)
        }
    }
    
    func getVideoThumbnail(_ url: String, completion: @escaping(UIImage)->()) {
        completion(#imageLiteral(resourceName: "video"))
    }
    
    func configure(_ data: VideoModel) {
        self.data = data
        lblTitle.text = data.title
        if let image = data.thumbnail {
            imgvPhoto.image = image
        }
        else {
            isLoading = true
            getVideoThumbnail(data.url, completion: { (downloaded) in
                self.isLoading = false
                self.imgvPhoto.image = downloaded
            })
        }
        
        imgvPhoto.touchUpInsideAction = { [weak self] in
            guard let self = self else { return }
            if let f = self.selectAction {
                f()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isLoading = false
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(panGesture)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}

extension VideoCollectionCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
