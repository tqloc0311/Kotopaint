//
//  UINavigationController.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/2/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension UINavigationController {
    
//    func pushViewControllerFromNib<T: UIViewController>(_ : T.Type) {
//        
//        let vc = T(nibName: String(describing: T.self), bundle: nil)
//        pushViewController(vc, animated: true)
//    }
    
}

extension UINavigationController {
    func pushViewController(viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
        pushViewController(viewController, animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    func popViewController(animated: Bool, completion: @escaping () -> ()) {
        popViewController(animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    func popToRootViewController(animated: Bool, completion: @escaping () -> ()) {
        popToRootViewController(animated: animated)
        
        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
