//
//  ProductDetailViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/24/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import ImageSlideshow

class ProductDetailViewController: BackButtonViewController {

    //  MARK: - Constants
    
    //  MARK: - Properties
    private var product: Product!
    private var source = [ImageSource]()
    
    //  MARK: - Outlets
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var excerptLabel: UILabel!
    @IBOutlet weak var notePriceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    
    //  MARK: - Actions
    @IBAction func slideshowGoPrevious(_ sender: Any) {
        if source.count == 0 {
            return
        }
        
        let currentIndex = slideshow.currentPage
        if currentIndex > 0 {
            slideshow.setCurrentPage(currentIndex - 1, animated: true)
        }
        else {
            slideshow.setCurrentPage(source.count - 1, animated: true)
        }
    }
    
    @IBAction func slideshowGoNext(_ sender: Any) {
        if source.count == 0 {
            return
        }
        
        let currentIndex = slideshow.currentPage
        if currentIndex < source.count - 1 {
            slideshow.setCurrentPage(currentIndex + 1, animated: true)
        }
        else {
            slideshow.setCurrentPage(0, animated: true)
        }
    }
    
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
        
        slideshow.backgroundColor = .clear
    }
    
    func setupSlideshow(urls: [URL]) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.source.removeAll()
            if urls.count == 0 {
                self.source.append(ImageSource(image: #imageLiteral(resourceName: "no-image")))
            }
            else {
                for url in urls {
                    guard
                        let data = try? Data(contentsOf: url),
                        let img = UIImage(data: data)
                    else {
                            continue
                    }
                    
                    self.source.append(ImageSource(image: img))
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.previousButton.isHidden = false
                self.nextButton.isHidden = false
                if self.source.count == 1 {
                    self.previousButton.isHidden = true
                    self.nextButton.isHidden = true
                }
                
                self.slideshow.backgroundColor = UIColor.clear
                self.slideshow.slideshowInterval = 0
                self.slideshow.pageIndicatorPosition = PageIndicatorPosition.init(horizontal: PageIndicatorPosition.Horizontal.center, vertical: PageIndicatorPosition.Vertical.bottom)
                self.slideshow.pageControl.currentPageIndicatorTintColor = (0x012169).toUIColor()
                self.slideshow.pageControl.pageIndicatorTintColor = UIColor.gray
                self.slideshow.contentScaleMode = .scaleAspectFill
                
                self.slideshow.setImageInputs(self.source)
            }
        }
    }
    
    func configure(product: Product) {
        self.navigationItem.title = product.title
        setupSlideshow(urls: product.imageURLs)
        excerptLabel.attributedText = product.excerpt.html()
        notePriceLabel.attributedText = product.notePrice.html()
        contentLabel.attributedText = product.content.html()
        guideLabel.attributedText = product.huongdan.html()
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, product: Product) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.product = product
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configure(product: product)
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
extension ProductDetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
