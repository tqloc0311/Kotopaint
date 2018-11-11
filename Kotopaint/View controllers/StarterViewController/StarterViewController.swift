//
//  StarterViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class StarterViewController: UIViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    
    //  MARK: - Outlets
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        
        let group = DispatchGroup()
        group.enter()
        APIHelper.requestToken { (_) in
            group.leave()
        }
        
        VideoRepository.shared.loadData()
        
        group.notify(queue: .main) {
            self.presentModalViewControllerFromStoryBoard(destinationClass: CustomRevealViewController.self)
        }
    }
}
