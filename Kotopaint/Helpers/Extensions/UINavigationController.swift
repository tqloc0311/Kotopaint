//
//  UINavigationController.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/2/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension UINavigationController {
    
    func pushViewControllerFromNib<T: UIViewController>(_ : T.Type) {
        
        let vc = T(nibName: String(describing: T.self), bundle: nil)
        pushViewController(vc, animated: true)
    }
    
}
