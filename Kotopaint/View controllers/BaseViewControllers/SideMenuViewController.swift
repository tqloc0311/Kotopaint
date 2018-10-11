//
//  SideMenuViewController.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/1/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated:true)
        
        if let revealVC = self.revealViewController() {
            let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: revealVC, action: #selector(SWRevealViewController.revealToggle(_:)))
            menuButton.tintColor = (0x15427D).toUIColor()
            self.navigationItem.leftBarButtonItem = menuButton
            
//            addRevealGesture()
            
        }
    }
}
