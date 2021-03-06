//
//  TabBarViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Constants
    
    // MARK: - Properties
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    override var selectedIndex: Int {
        didSet {
            tabBarController(self, didSelect: viewControllers![selectedIndex])
        }
    }
    
    // MARK: - Outlets
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    // Configure tab bar items
    func configTabBarItems() {
        
        let homeVC = UIViewController.viewControllerFromNib(HomeViewController.self)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "tab_icon_home").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tab_icon_selected_home").withRenderingMode(.alwaysOriginal))
        
        let colorGalleryVC = UIViewController.viewControllerFromNibWithNav(ColorGalleryViewController.self)
        colorGalleryVC.tabBarItem = UITabBarItem(title: "Bảng màu", image: #imageLiteral(resourceName: "tab_icon_colors").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tab_icon_selected_colors").withRenderingMode(.alwaysOriginal))

        let categoryVC = UIViewController.viewControllerFromNibWithNav(CategoryViewController.self)
        categoryVC.tabBarItem = UITabBarItem(title: "Sản phẩm", image: #imageLiteral(resourceName: "tab_icon_product").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tab_icon_selected_product").withRenderingMode(.alwaysOriginal))

        let colorSchemeVC = UIViewController.viewControllerFromNibWithNav(PhoiMauCategoryViewController.self)
        colorSchemeVC.tabBarItem = UITabBarItem(title: "Phối màu", image: #imageLiteral(resourceName: "tab_icon_color_mix").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tab_icon_selected_color_mix").withRenderingMode(.alwaysOriginal))

        let paintCalculatorVC = UIViewController.viewControllerFromNibWithNav(PaintCalculatorV2ViewController.self)
        paintCalculatorVC.tabBarItem = UITabBarItem(title: "Tính sơn", image: #imageLiteral(resourceName: "tab_icon_calculator").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "tab_icon_selected_calculator").withRenderingMode(.alwaysOriginal))
        
        viewControllers = [
            homeVC,
            colorGalleryVC,
            categoryVC,
            colorSchemeVC,
            paintCalculatorVC,
        ]
        
        self.tabBar.barTintColor = .white
        hero.isEnabled = true
        hero.tabBarAnimationType = .fade
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabBarItems()
        self.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let newTabBarHeight = defaultTabBarHeight + 16.0
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newFrame
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let nav = viewController as? UINavigationController {
            nav.popToRootViewController(animated: false)
        }
    }
}
