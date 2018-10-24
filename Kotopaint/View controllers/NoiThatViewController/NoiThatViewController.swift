//
//  NoiThatViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/23/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class NoiThatViewController: BackButtonViewController {

    //  MARK: - Constants
    let segmentColor = (0xDCDBE3).toUIColor()
    
    //  MARK: - Properties
    var selectedTab = 0
    var dataSource = ImageRepository.shared.getByGroup(.ngoaithat)
    
    //  MARK: - Outlets
    @IBOutlet var viewSegment: UIView!
    @IBOutlet var viewTabs: [ViewButton]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupView() {
        
        let panGesture = UIPanGestureRecognizer { [weak self] (recognizer) in
            guard let self = self else { return }
            if let panGesture = recognizer as? UIPanGestureRecognizer, let isRight = panGesture.isLeftToRight(self.view), isRight {
                self.didBack()
            }
        }
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(nibName: ImageCollectionCell.self)
    }
    
    func setupSegment() {
        for tab in viewTabs {
            tab.touchUpInsideAction = { [weak self] in
                guard let self = self else { return }
                let index = tab.tag - 1001
                if self.selectedTab == index {return}
                self.selectedTab = index
                self.setSelectedTab(self.selectedTab)
            }
        }
    }
    
    func setSelectedTab(_ index: Int) {
        for tab in viewTabs {
            if tab.tag == 1000 + index + 1 {
                tab.viewWithTag(999)?.removeFromSuperview()
                let bg = UIImageView(frame: tab.bounds)
                bg.image = #imageLiteral(resourceName: "noithat_tab_selected_bg")
                bg.tag = 999
                tab.insertSubview(bg, at: 0)
            }
            else {
                tab.viewWithTag(999)?.removeFromSuperview()
            }
        }
        
        loadData()
    }
    
    func loadData() {
        dataSource.removeAll()
        var g = ImageModelGroup.living
        switch selectedTab {
        case 0:
            g = .living
        case 1:
            g = .bed
        case 2:
            g = .dining
        case 3:
            g = .kids
        default:
            break
        }
        
        dataSource = ImageRepository.shared.getByGroup(g)
        
        self.collectionView.reloadData()
    }
    
    func goNext(model: ImageModel) {
        
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ngoại thất"
        setupView()
        setupSegment()
        selectedTab = 0
        setupCollectionView()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setSelectedTab(selectedTab)
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension NoiThatViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UICollectionView
extension NoiThatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ImageCollectionCell.self, indexPath: indexPath)
        
        cell.data = dataSource[indexPath.item]
        cell.imgvPhoto.touchUpInsideAction = { [weak self] in
            guard let self = self else { return }
            self.goNext(model: cell.data)
        }
        cell.panAction = { [weak self] isRight in
            guard let self = self else { return }
            if isRight {
                self.didBack()
            }
            else {
                self.goNext(model: cell.data)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  0
        let collectionViewSize = collectionView.frame.size.width - padding
        let width = collectionViewSize/2
        let imageRatio: CGFloat = 3/4
        return CGSize(width: width, height: width * imageRatio)
    }
}
