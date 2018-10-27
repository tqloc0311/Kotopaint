//
//  PhoiMauItemViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/26/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class PhoiMauItemViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    private var dataSource = [PhoiMauItem]()
    private var phoimauCategory: PhoiMauCategory?
    
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
        
        collectionView.register(nibName: PhoiMauItemCollectionViewCell.self)
    }
    
    func goNext(model: PhoiMauItem) {
        
    }
    
    func configure() {
        self.navigationItem.title = phoimauCategory?.name ?? ""
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, phoimauCategory: PhoiMauCategory) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.phoimauCategory = phoimauCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ngoại thất"
        setupView()
        setupCollectionView()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension PhoiMauItemViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - UICollectionView
extension PhoiMauItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PhoiMauItemCollectionViewCell.self, indexPath: indexPath)
        
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
