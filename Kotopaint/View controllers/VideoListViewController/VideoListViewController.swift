//
//  VideoListViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/23/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoListViewController: BackButtonViewController {

    //  MARK: - Constants
    let cellIdentifier = "VideoCollectionCell"
    
    //  MARK: - Properties
    var data = VideoRepository.shared.data
    
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
        
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delaysContentTouches = false
        for view in collectionView.subviews {
            if view is UIScrollView {
                (view as! UIScrollView).delaysContentTouches = false
                break
            }
        }
    }
    
    func openUrl(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func openVideo(_ video: VideoModel) {
        let vc = UIViewController.viewControllerFromNib(VideoPlayerViewController.self)
        vc.model = video
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Danh sách video"
        setupCollectionView()
        setupView()
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
extension VideoListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension VideoListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? VideoCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(data[indexPath.item])
        cell.selectAction = { [unowned self] in
            self.openVideo(cell.data)
        }
        
        cell.panAction = { [unowned self] (isRight) in
            if isRight {
                self.didBack()
            }
            else {
                self.openVideo(cell.data)
                
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  0
        let collectionViewSize = collectionView.frame.size.width - padding
        let width = collectionViewSize / 2
        let imageRatio: CGFloat = 3/4
        return CGSize(width: width, height: width * imageRatio)
    }
}
