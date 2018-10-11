//
//  MenuViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UIViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    var dataSource = SideMenuRepository.shared.storage
    
    //  MARK: - Outlets
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    
    // Configure table view
    func configureTableview() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.register(nibName: MenuCell.self)
    }
    
    func goToViewController(_ vc: UIViewController) {
        guard let revealVC = self.revealViewController() as? CustomRevealViewController else {
            return
        }
        
        revealVC.tabBarVC.selectedIndex = 0
        (revealVC.tabBarVC.viewControllers![0] as! UINavigationController).pushViewController(vc, animated: true)
        revealVC.revealToggle(animated: false)
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableview()
    }
}

// MARK: - Table view data source
extension SideMenuTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MenuCell.self)
        let item = dataSource[indexPath.row]
        
        cell.configure(data: item)
        cell.selectAction = {
            guard let revealVC = self.revealViewController() as? CustomRevealViewController else {
                return
            }
            
            switch item.id {
            case 0:
                revealVC.tabBarVC.selectedIndex = 0
                revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
                break
            case 1:
                revealVC.tabBarVC.selectedIndex = 0
                revealVC.pushFrontViewController(UIViewController.viewControllerFromNibWithNav(RegisterFormViewController.self), animated: true)
                break
            case 2:
                revealVC.tabBarVC.selectedIndex = 2
                revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
                break
            case 3:
                revealVC.tabBarVC.selectedIndex = 1
                revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
                break
            case 4:
                revealVC.tabBarVC.selectedIndex = 3
                revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
                break
            case 5:
                revealVC.tabBarVC.selectedIndex = 4
                revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
                break
            case 6:
                break
            case 7:
                break
            case 8:
                self.goToViewController(UIViewController.viewControllerFromNib(ContactViewController.self))
                break
            default:
                break
            }
            
            tableView.reloadData()
        }
        return cell
    }
}

// MARK: - Table view delegate
extension SideMenuTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
