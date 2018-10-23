//
//  NgoaiThatViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/23/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class NgoaiThatViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    var dataSource = ImageRepository.shared.getByGroup(.ngoaithat)
    
    //  MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(nibName: ImageCollectionCell.self)
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
        setupCollectionView()
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension NgoaiThatViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UICollectionView
extension NgoaiThatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ImageCollectionCell.self, indexPath: indexPath)
        
        cell.data = dataSource[indexPath.item]
        cell.imgvPhoto.touchUpInsideAction = { [unowned self] in
            self.goNext(model: cell.data)
        }
        cell.panAction = { [unowned self] isRight in
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
