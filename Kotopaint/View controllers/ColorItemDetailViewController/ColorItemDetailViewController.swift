//
//  ColorItemDetailViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 11/1/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class ColorItemDetailViewController: UIViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    fileprivate var colorItem: ColorItem!
    
    //  MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupView() {
        let tap = UITapGestureRecognizer { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
        
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
        imageView.backgroundColor = colorItem.color
        imageView.hero.id = "colorItemDetail_\(colorItem.id)"
    }
    
    //  MARK: - View Lifecycle
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, colorItem: ColorItem) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.colorItem = colorItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}
