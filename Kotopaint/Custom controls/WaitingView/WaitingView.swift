//
//  WaitingView.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/4/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class WaitingView: UIView {
    
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        indicatorView.startAnimating()
    }
}


var WAITING_VIEW = UIView()

func showWaiting() {
    WAITING_VIEW.removeFromSuperview()
    let window = UIApplication.shared.keyWindow!
    WAITING_VIEW = UIView.loadFromNibNamed("WaitingView")!
    WAITING_VIEW.frame = window.bounds
    window.addSubview(WAITING_VIEW)
    WAITING_VIEW.transform = CGAffineTransform(scaleX: 2, y: 2)
    WAITING_VIEW.alpha = 0
    UIView.animate(withDuration: 0.2) {
        WAITING_VIEW.transform = CGAffineTransform.identity
        WAITING_VIEW.alpha = 1
    }
}

func hideWaiting() {
    WAITING_VIEW.transform = CGAffineTransform.identity
    WAITING_VIEW.alpha = 1
    UIView.animate(withDuration: 0.15, animations: {
        WAITING_VIEW.transform = CGAffineTransform(scaleX: 2, y: 2)
        WAITING_VIEW.alpha = 0
    }) { (_) in
        WAITING_VIEW.removeFromSuperview()
    }
}
