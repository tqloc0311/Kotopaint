//
//  BackButtonViewController.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/4/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ActionKit

protocol BackButtonViewControllerDelegate {
    func didBack()
}

class BackButtonViewController: UIViewController {
    
    @objc func didBack() {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back")) { [weak self] in
            guard let self = self else { return }
            self.didBack()
        }
        barButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = barButton
    }
}
