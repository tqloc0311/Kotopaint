//
//  ColorGalleryViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ActionKit

class ColorGalleryViewController: UIViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    
    //  MARK: - Outlets
    @IBOutlet weak var backButton: ImageButton!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupView() {
        backButton.touchUpInsideAction = {
            self.back()
        }
        
        let panGesture = UIPanGestureRecognizer { (recognizer) in
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isRight(self.view), isRight {
                self.back()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    func back() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ColorGalleryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
