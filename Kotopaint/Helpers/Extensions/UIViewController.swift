//
//  UIViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func addRevealGesture(){
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func removeRevealGesture(){
        self.view.removeGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.removeGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
    
    func showErrorAlert(title: String, subtitle: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConfirmAlert(title: String, subtitle: String, confirmTitle: String, cancelTitle: String, confirmAction: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: { _ in
            confirmAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentModalViewControllerFromStoryBoard<T: UIViewController>(destinationClass : T.Type) {
        
        guard let vc = UIStoryboard(name: String(describing: T.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            return
        }
        self.presentModalViewController(destination: vc)
    }
    
    func presentModalViewControllerFromNib<T: UIViewController>(destinationClass : T.Type) {
        
        let vc = T(nibName: String(describing: T.self), bundle: nil)
        self.presentModalViewController(destination: vc)
    }
    
    func presentModalViewController(destination : UIViewController, completion: (() -> Void)? = nil) {
        
        destination.modalTransitionStyle = .crossDissolve
        self.present(destination, animated: true, completion: completion)
    }
    
    static func viewControllerFromNib<T: UIViewController>(_ : T.Type) -> T {
        
        return T(nibName: String(describing: T.self), bundle: nil)
    }
    
    static func viewControllerFromNibWithNav<T: UIViewController>(_ : T.Type) -> UINavigationController {
        
        return UINavigationController(rootViewController: viewControllerFromNib(T.self))
    }
    
    static func viewControllerFromStoryBoard<T: UIViewController>(_ : T.Type) -> T? {
        
        guard let vc = UIStoryboard(name: String(describing: T.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            return nil
        }
        
        return vc
    }
    
    static func viewControllerFromStoryBoardWithNav<T: UIViewController>(_ : T.Type) -> UINavigationController? {
        
        if let vc = viewControllerFromStoryBoard(T.self) {
            let nav = UINavigationController(rootViewController: vc)
            return nav
        }
        else {
            return nil
        }
    }
}
