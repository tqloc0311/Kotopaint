//
//  InternetAlert.swift
//  Taxi UXXX Driver
//
//  Created by ProStageVN on 6/28/17.
//  Copyright © 2017 ProStageVN. All rights reserved.
//

import UIKit

class InternetAlert {
    
    // Shared instance
    static var instance = InternetAlert()
    
    // Constants
    private let bannerDissapearAnimationDuration = 0.5
    private var padding: CGFloat = 4
    
    // MARK: - Properties
    private var bannerWindow : UIWindow?
    
    private var viewContainer: UIView!
    private var lblAlert: UILabel!

    private var reachability = Reachability()!
   
    var isShowing = false {
        didSet {
            if isShowing {
                showOnTopOfStatusBar(viewContainer)
            }
            else {
                closeNotificationOnTopOfStatusBar()
            }
        }
    }
    
    // MARK: - Methods
    private func showOnTopOfStatusBar(_ notificationView: UIView, animated: Bool = true) {
        if bannerWindow == nil {
            bannerWindow = UIWindow()
            bannerWindow!.windowLevel = UIWindow.Level.statusBar + 1
            bannerWindow!.backgroundColor = UIColor.clear
        }
        
        let topHeight = UIApplication.shared.statusBarFrame.size.height
        
        let height = max(topHeight, notificationView.frame.height)
        let width = UIScreen.main.bounds.width
        
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        bannerWindow!.frame = frame
        bannerWindow!.isHidden = false
        
        bannerWindow!.addSubview(notificationView)
        
        if animated {
            notificationView.frame = frame.offsetBy(dx: 0, dy: -frame.height)
            bannerWindow!.layoutIfNeeded()
            
            // Show appearing animation, schedule calling closing selector after completed
            UIView.animate(withDuration: bannerDissapearAnimationDuration, animations: {
                let frame = notificationView.frame
                notificationView.frame = frame.offsetBy(dx: 0, dy: frame.height)
            })
        } else {
            notificationView.frame = frame
        }
    }
    
    private func closeNotificationOnTopOfStatusBar() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        UIView.animate(withDuration: bannerDissapearAnimationDuration,
                       animations: { () -> Void in
                        let frame = self.viewContainer.frame
                        self.viewContainer.frame = frame.offsetBy(dx: 0, dy: -frame.height)
        },
                       completion: { (finished) -> Void in
                        self.viewContainer.removeFromSuperview()
                        self.bannerWindow?.isHidden = true
        }
        )
    }
    
    // Constructors
    init() {
        if bannerWindow == nil {
            bannerWindow = UIWindow()
            bannerWindow!.windowLevel = UIWindow.Level.statusBar + 1
            bannerWindow!.backgroundColor = UIColor.clear
        }
        
        lblAlert = UILabel(frame: CGRect(x: 0, y: 0, width: bannerWindow!.frame.width - padding * 2, height: CGFloat.greatestFiniteMagnitude))
        lblAlert.numberOfLines = 0
        lblAlert.font = UIFont.systemFont(ofSize: 11)
        lblAlert.text = "Chúng tôi không tìm thấy kết nối mạng. Vui lòng kiểm tra lại."
        lblAlert.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblAlert.backgroundColor = .clear
        lblAlert.textColor = .white
        lblAlert.sizeToFit()
        
        viewContainer = UIView(frame: CGRect(x: 0, y: 0, width: bannerWindow!.frame.width, height: lblAlert.frame.height + padding * 2))
        
        viewContainer.backgroundColor = .red
        viewContainer.addSubview(lblAlert)
        lblAlert.frame = CGRect(origin: CGPoint(x: padding, y: padding), size: lblAlert.frame.size)
    }
    
    // Destructor
    deinit {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
