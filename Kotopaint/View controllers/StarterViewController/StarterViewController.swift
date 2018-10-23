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
        UserRepository.shared.getToken { (_) in
            group.leave()
        }
//        group.enter()
//        CategoryRepository.shared.loadData { (_) in
//            group.leave()
//        }
        
//
        group.enter()
        executeOnBackground(task: {
            ImageRepository.shared.loadData()
        }, completion: {
            group.leave()
        }, delay: 0)
        group.enter()
        executeOnBackground(task: {
            VideoRepository.shared.loadData()
        }, completion: {
            group.leave()
        }, delay: 0)
        
        group.notify(queue: .main) {
            self.presentModalViewControllerFromStoryBoard(destinationClass: CustomRevealViewController.self)
        }
    }
}
