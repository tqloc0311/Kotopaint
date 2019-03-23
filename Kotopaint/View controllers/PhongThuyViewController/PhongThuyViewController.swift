//
//  PhongThuyViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/23/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import DropDown

class PhongThuyViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    private let genderDataSource = [
        "Nam",
        "Nữ"
    ]
    
    private let directionDataSource = [
        "Đông",
        "Tây",
        "Nam",
        "Bắc",
        "Đông Bắc",
        "Đông Nam",
        "Tây Bắc",
        "Tây Nam",
    ]
    
    //  MARK: - Outlets
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var genderButton: ViewButton!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var directionButton: ViewButton!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    //  MARK: - Actions
    @IBAction func calculate(_ sender: Any) {
        if birthdayTextField.text == "" {
            birthdayTextField.becomeFirstResponder()
        }
        else {
            let gender = PhongThuy.Gender(rawValue: genderLabel.tag) ?? .male
            let direction = PhongThuy.Direction(rawValue: directionButton.tag) ?? .east
            let date = Date(string: birthdayTextField.text!) ?? Date()
            
            showWaiting()
            PhongThuyRepository.shared.loadData(birthday: date, direction: direction, gender: gender) { [weak self] (errorMsg, result) in
                guard let self = self else { return }
                hideWaiting()
                
                let vc = PhongThuyDetailViewController(nibName: nil, bundle: nil, htmlString: result)
                self.navigationController?.pushViewController(vc, animated: true)
//                self.resultLabel.attributedText = result
            }
        }
    }
    
    //  MARK: - Methods
    func setupView() {
        
        let panGesture = UIPanGestureRecognizer { [weak self] (recognizer) in
            guard let self = self else { return }
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isLeftToRight(self.view), isRight {
                self.didBack()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
        
        let borderColor = UIColor(hexString: "EBECEB")!
        
        boxView.setBorder(color: borderColor, width: 1, corner: 8)
        calculateButton.setBorder(color: .clear, width: 0, corner: calculateButton.bounds.height / 2)
        genderButton.setBorder(color: borderColor, width: 1, corner: 8)
        genderButton.backgroundColor = .clear
        directionButton.setBorder(color: borderColor, width: 1, corner: 8)
        directionButton.backgroundColor = .clear
        
        birthdayTextField.delegate = self
        
        genderButton.touchUpInsideAction = selectGender
        directionButton.touchUpInsideAction = selectDirection
        
        resultLabel.text = ""
    }
    
    private func showDropDown(anchorView: UIView, dataSource: [String], selectingHandler: @escaping (Int, String)->()) {
        let dropDown = DropDown()
        dropDown.anchorView = anchorView
        
        dropDown.bottomOffset = CGPoint(x: 0, y: anchorView.frame.height)
        
        DropDown.setupDefaultAppearance()
        let appearance = DropDown.appearance()
        appearance.backgroundColor = .white
        appearance.selectionBackgroundColor = .clear
        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadius = 10
        appearance.shadowColor = .lightGray//(0x68C9F8).toUIColor()
        appearance.shadowOpacity = 0.7
        appearance.shadowRadius = 10
        appearance.animationduration = 0.25
        
        dropDown.dataSource = dataSource
        dropDown.selectionAction = { (index, item) in
            selectingHandler(index, item)
        }
        dropDown.dismissMode = .automatic
        dropDown.direction = .bottom
        
        dropDown.show()
    }
    
    func selectGender() {
        showDropDown(anchorView: genderButton, dataSource: genderDataSource) { [weak self] (index, text) in
            guard let self = self else { return }
            self.genderLabel.text = text
            self.genderLabel.tag = index
        }
    }
    
    func selectDirection() {
        showDropDown(anchorView: directionButton, dataSource: directionDataSource) { [weak self] (index, text) in
            guard let self = self else { return }
            self.directionLabel.text = text
            self.directionLabel.tag = index
        }
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Phong thủy"
        setupView()
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
        else if let nav = navigationController {
            nav.dismiss(animated: true, completion: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PhongThuyViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension PhongThuyViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == birthdayTextField {
            DatePickerDialog(locale: Locale(identifier: "vi_VN")).show("Ngày sinh", doneButtonTitle: "Chọn", cancelButtonTitle: "Quay lại", datePickerMode: .date) { [weak self]
                (date) -> Void in
                guard let self = self else { return }
                if let dt = date {
                    self.birthdayTextField.text = dt.toString()
                }
            }
        }
        return false
    }
}
