//
//  HomeViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ScalingCarousel

class HomeViewController: SideMenuViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    var menuList = HomeMenuRepository.shared.storage
    
    //  MARK: - Outlets
    @IBOutlet weak var carouselView: ScalingCarouselView!
    @IBOutlet weak var goPreviousButton: UIButton!
    @IBOutlet weak var goNextButton: UIButton!
    
    //  MARK: - Actions
    @IBAction func left(_ sender: Any) {
        guard let current = carouselView.centerCellIndexPath else {return}
        let nextItem = current.row - 1
        if nextItem >= 0 {
            let indexPath = IndexPath(row: nextItem, section: 0)
            carouselView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func right(_ sender: Any) {
        guard let current = carouselView.centerCellIndexPath else {return}
        let nextItem = current.row + 1
        if nextItem <= menuList.count - 1 {
            let indexPath = IndexPath(row: nextItem, section: 0)
            carouselView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func search(_ sender: Any) {
        
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        self.revealViewController()?.revealToggle(animated: true)
    }
    
    //  MARK: - Methods
    func setupView() {
        hero.isEnabled = true
    }
    
    func setupCollectionView() {
        carouselView.register(nibName: MenuCollectionCell.self)
        carouselView.inset = 0
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.delaysContentTouches = false
        for view in carouselView.subviews {
            if view is UIScrollView {
                (view as! UIScrollView).delaysContentTouches = false
                break
            }
        }
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        goPreviousButton.isHidden = true
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuCollectionCell.self), for: indexPath) as? MenuCollectionCell else {
            return UICollectionViewCell()
        }
        
        let item = menuList[indexPath.row]
        cell.configure(item)
        (cell.mainView as! ViewButton).touchUpInsideAction = {
            switch item.id {
            case 0:
                self.tabBarController?.selectedIndex = 1
                break
            case 1:
                self.tabBarController?.selectedIndex = 2
                break
            case 2:
//                self.performSegue(withIdentifier: "idea", sender: nil)
                break
            case 3:
//                self.performSegue(withIdentifier: "video", sender: nil)
                break
            case 4:
                self.tabBarController?.selectedIndex = 3
                break
            case 5:
                self.tabBarController?.selectedIndex = 4
                break
            case 6:
//                self.performSegue(withIdentifier: "phongthuy", sender: nil)
                break
            case 7:
                self.navigationController?.pushViewController(UIViewController.viewControllerFromNib(ContactViewController.self), animated: true)
                break
            default:
                break
            }
        }
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        carouselView.didScroll()
        
        goPreviousButton.isHidden = false
        goNextButton.isHidden = false
        
        if let currentIndex = carouselView.centerCellIndexPath?.row {
            if currentIndex == 0 {
                goPreviousButton.isHidden = true
            }
            else if currentIndex == menuList.count - 1 {
                goNextButton.isHidden = true
            }
        }
    }
}
