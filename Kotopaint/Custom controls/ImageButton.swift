//
//  ImageButton.swift
//  Chat Novel
//
//  Created by ProStageVN on 12/18/17.
//  Copyright © 2017 Tom Company. All rights reserved.
//

import UIKit

class ImageButton: UIImageView {
    
    public var rounded: Bool = false {
        didSet {
            if rounded {
                self.layer.cornerRadius = self.bounds.height / 2
            }
            else {
                self.layer.cornerRadius = 0
            }
        }
    }
    
    public var isEnabled: Bool = false {
        didSet {
            if isEnabled {
                self.alpha = 1
                self.isUserInteractionEnabled = true
            }
            else {
                self.alpha = 0.3
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    var touchUpInsideAction: (()->())?
    
    @objc func handleAction() {
        self.alpha = 1
        if let f = touchUpInsideAction {
            f()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAction)))
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    deinit {
        touchUpInsideAction = nil
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.3
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
}

