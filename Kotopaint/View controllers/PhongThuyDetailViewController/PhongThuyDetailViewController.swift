//
//  PhongThuyDetailViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PhongThuyDetailViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    private var htmlString: String!
    
    //  MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    
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
        
        if let string = htmlString {
            webView.loadHTMLString(string, baseURL: nil)

        }
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, htmlString: String) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.htmlString = htmlString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Phong Thủy"
        setupView()
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PhongThuyDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

