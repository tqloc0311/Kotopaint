//
//  ColorSchemeViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ActionKit

class ColorSchemeViewController: BackButtonViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    
    //  MARK: - Outlets
    @IBOutlet weak var noiThatButton: ViewButton!
    @IBOutlet weak var ngoaiThatButton: ViewButton!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func addPanGesture(to view: UIView, rightToLeftAction: (()->())? = nil) {
        let panGesture = UIPanGestureRecognizer { [weak self] (recognizer) in
            guard let self = self else { return }
            if recognizer.state == .ended {
                if let panGesture = recognizer as? UIPanGestureRecognizer, let isLeftToRight = panGesture.isLeftToRight(view) {
                    if isLeftToRight {
                        self.didBack()
                    }
                    else {
                        rightToLeftAction?()
                    }
                    
                }
            }
            
        }
        panGesture.delegate = self
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGesture)
    }
    
    func goToNgoaiThat() {
        self.navigationController?.pushViewControllerFromNib(NgoaiThatViewController.self)
    }
    
    func goToNoiThat() {
        self.navigationController?.pushViewControllerFromNib(NoiThatViewController.self)
    }
    
    func setupView() {
        addPanGesture(to: self.view)
        
        addPanGesture(to: ngoaiThatButton) { [weak self] in
            guard let self = self else { return }
            self.goToNgoaiThat()
        }
        ngoaiThatButton.dropShadow()
        ngoaiThatButton.touchUpInsideAction = goToNgoaiThat
        
        addPanGesture(to: noiThatButton) { [weak self] in
            guard let self = self else { return }
            self.goToNoiThat()
        }
        noiThatButton.dropShadow()
        noiThatButton.touchUpInsideAction = goToNoiThat
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Phần mềm phối màu"
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
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ColorSchemeViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
