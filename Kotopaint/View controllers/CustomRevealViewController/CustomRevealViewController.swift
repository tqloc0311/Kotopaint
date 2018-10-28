//
//  CustomRevealViewController.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/1/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class CustomRevealViewController: SWRevealViewController {
    
    var tabBarVC: TabBarViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rearViewRevealWidth = 280
        
        self.setRear(UIViewController.viewControllerFromNib(SideMenuTableViewController.self), animated: true)

        tabBarVC = UIViewController.viewControllerFromNib(TabBarViewController.self)
        
        tabBarVC.view.addGestureRecognizer(tapGestureRecognizer())
        self.setFront(tabBarVC, animated: false)
    }
}
