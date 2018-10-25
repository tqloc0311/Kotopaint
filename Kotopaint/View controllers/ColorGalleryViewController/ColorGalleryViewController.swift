//
//  ColorGalleryViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ActionKit

class ColorGalleryViewController: BackButtonViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    var data = [ColorGallery]()
    
    //  MARK: - Outlets
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
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
    }
    
    func setupCollectionView() {
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        
        galleryCollectionView.register(nibName: ColorGalleryCollectionViewCell.self)
    }
    
    func selectGallery(_ gallery: ColorGallery) {
        let vc = ColorItemViewController(nibName: nil, bundle: nil, gallery: gallery)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadData(completion: (()->())? = nil) {
        showWaiting()
        ColorGalleryRepository.shared.loadData { [weak self] (errorMsg, result) in
            hideWaiting()
            guard let self = self else { return }
            
            if errorMsg != "" {
                self.showErrorAlert(title: "Lỗi", subtitle: errorMsg, buttonTitle: "Try again")
            }
            else {
                self.data = result
                self.galleryCollectionView.reloadData()
            }
            
            completion?()
        }
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Bộ sưu tập màu"
        setupView()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        if let tabBarVC = self.tabBarController {
            tabBarVC.selectedIndex = 0
        }
        else if let revealVC = self.revealViewController() as? CustomRevealViewController {
            revealVC.pushFrontViewController(revealVC.tabBarVC, animated: true)
            revealVC.tabBarVC.selectedIndex = 0
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ColorGalleryViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ColorGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ColorGalleryCollectionViewCell.self, indexPath: indexPath)
        
        let item = data[indexPath.item]
        cell.configure(item)
        cell.selectAction = { [weak self] in
            guard let self = self else { return }
            self.selectGallery(item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  0
        let collectionViewSize = collectionView.frame.size.width - padding
        let width = collectionViewSize / 2
        let imageRatio: CGFloat = 4/5
        return CGSize(width: width, height: width * imageRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
}
