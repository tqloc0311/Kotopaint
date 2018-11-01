//
//  ImageViewerViewController.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/28/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class ImageViewerViewController: UIViewController {
    
    // Constants
    
    // Properties
    var photo: UIImage?
    var imageViewHeroID = ""
    
    // Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    // Actions
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Methods
    
    // Navigation
    
    // View lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, image: UIImage?, imageViewHeroID: String = "") {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.photo = image
        self.imageViewHeroID = imageViewHeroID
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = photo
        imageView.hero.id = imageViewHeroID
        self.scrollView.minimumZoomScale = 1.0;
        self.scrollView.maximumZoomScale = 10.0;
        self.scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension ImageViewerViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
