//
//  AppDelegate.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import GoogleMaps
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = Reachability()

    private func reachabilitySetup() {
        if let reachability = reachability {
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
            do{
                try reachability.startNotifier()
            }catch{
                print("could not start reachability notifier")
            }
        }
    }
    
    @objc private func reachabilityChanged(_ note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            InternetAlert.instance.isShowing = false
        case .cellular:
            print("Reachable via Cellular")
            InternetAlert.instance.isShowing = false
        case .none:
            print("Network not reachable")
            InternetAlert.instance.isShowing = true
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(GOOGLE_MAPS_SDK_KEY)
        IQKeyboardManager.shared.enable = true
        reachabilitySetup()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TAB_BAR_TEXT_COLOR], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TAB_BAR_SELECTED_TEXT_COLOR], for: .selected)
        
        let starterVC = UIViewController.viewControllerFromNib(StarterViewController.self)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = starterVC
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

