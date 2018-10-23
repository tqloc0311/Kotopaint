//
//  RegisterFormViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class RegisterFormViewController: BackButtonViewController {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    // MARK: - Actions
    @IBAction func send(_ sender: Any) {
    }
    
    // MARK: - Methods
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if let isRight = recognizer.isLeftToRight(view), isRight {
            didBack()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Liên hệ mở đại lý"
        
        btnSend.layer.cornerRadius = 8
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        if let tabBarVC = self.tabBarController {
            tabBarVC.selectedIndex = 0
        }
        else if let revealVC = self.revealViewController() as? CustomRevealViewController {
            revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
            revealVC.tabBarVC.selectedIndex = 0
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension RegisterFormViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
