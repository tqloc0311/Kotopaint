//
//  PhoiMauViewController.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/27/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PhoiMauViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    var phoimauItem: PhoiMauItem!
    
    //  MARK: - Outlets
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupView() {
        
        let panGesture = UIPanGestureRecognizer { (recognizer) in
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isLeftToRight(self.view), isRight {
                self.didBack()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    func configure() {
        self.navigationItem.title = phoimauItem.title
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, phoimauItem: PhoiMauItem) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.phoimauItem = phoimauItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
extension PhoiMauViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
