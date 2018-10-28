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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: - Actions
    @IBAction func send(_ sender: Any) {
        send()
    }
    
    // MARK: - Methods
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if let isRight = recognizer.isLeftToRight(view), isRight {
            didBack()
        }
    }
    
    func send() {
        if nameTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập tên", buttonTitle: "Thử lại")
        }
        else if emailTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập email", buttonTitle: "Thử lại")
        }
        else if !emailTextField.text!.isValidEmail() {
            showErrorAlert(title: "Lỗi", subtitle: "Email không đúng!", buttonTitle: "Thử lại")
        }
        else if phoneTextField.text == "" {
            showErrorAlert(title: "Lỗi", subtitle: "Vui lòng nhập số điện thoại", buttonTitle: "Thử lại")
        }
        else {
            self.view.endEditing(true)
            showErrorAlert(title: "Thành công", subtitle: "Đã gửi đăng ký!", buttonTitle: "OK")
            clear()
        }
    }
    
    func clear() {
        nameTextField.text = ""
        emailTextField.text = ""
        phoneTextField.text = ""
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Liên hệ mở đại lý"
        
        sendButton.layer.cornerRadius = 8
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

extension RegisterFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
            break
        case emailTextField:
            phoneTextField.becomeFirstResponder()
            break
        case phoneTextField:
            send()
            break
        default:
            break
        }
        return true
    }
}
