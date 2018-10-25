//
//  ColorItemViewController.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/24/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ActionKit

class ColorItemViewController: BackButtonViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    private var data = [ColorItem]()
    
    //  MARK: - Outlets
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
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
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
        colorCollectionView.register(nibName: ColorItemCollectionViewCell.self)
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, gallery: ColorGallery) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.data = gallery.colorItems
        self.navigationItem.title = gallery.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ColorItemViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ColorItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ColorItemCollectionViewCell.self, indexPath: indexPath)
        
        let item = data[indexPath.item]
        cell.configure(item)
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  0
        let collectionViewSize = collectionView.frame.size.width - padding
        let width = collectionViewSize / 3
        let imageRatio: CGFloat = 4/5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
}
