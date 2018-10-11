//
//  RegisterFormViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class RegisterFormViewController: SideMenuViewController {
    
    // MARK: - Constants
    
    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    // MARK: - Actions
    
    // MARK: - Methods
    func setupView() {
        self.navigationItem.title = "Liên hệ mở đại lý"
        hero.isEnabled = true
        btnSend.layer.cornerRadius = 8
//        let panGesture = UIPanGestureRecognizer { (recognizer) in
//            if let isRight = recognizer.isRight(view), isRight {
//                back()
//            }
//        }//UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
//        panGesture.delegate = self
//        self.view.isUserInteractionEnabled = true
//        self.view.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension RegisterFormViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
