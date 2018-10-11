//
//  BackButtonViewController.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/4/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ActionKit

class BackButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back")) {
            self.navigationController?.popViewController(animated: true)
        }
        barButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = barButton
    }
}
