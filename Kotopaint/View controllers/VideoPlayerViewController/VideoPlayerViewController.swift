//
//  VideoPlayerViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/23/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import TRVideoView
import WebKit
import NVActivityIndicatorView

class VideoPlayerViewController: BackButtonViewController {
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    var model: VideoModel!
    
    //  MARK: - Outlets
    @IBOutlet weak var playerContainerView: TRVideoView!
    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    
    //  MARK: - Actions
    
    //  MARK: - Methods
    func setupVideoPlayer() {
        guard let videoURL = model.videoURL else { return }
        let playerView = TRVideoView(text: "\(model.title) \(videoURL)")
        
        playerView.frame = playerContainerView.bounds
        playerView.navigationDelegate = self
        
        playerContainerView.insertSubview(playerView, at: 0)
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: playerView, attribute: .top, relatedBy: .equal, toItem: playerContainerView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: playerView, attribute: .bottom, relatedBy: .equal, toItem: playerContainerView, attribute: .bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: playerView, attribute: .leading, relatedBy: .equal, toItem: playerContainerView, attribute: .leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: playerView, attribute: .trailing, relatedBy: .equal, toItem: playerContainerView, attribute: .trailing, multiplier: 1, constant: 0)
        playerContainerView.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = model.title
        
        indicatorView.startAnimating()
        
        setupVideoPlayer()
    }
    
    // MARK: - Override BackButtonViewController methods
    override func didBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension VideoPlayerViewController: WKNavigationDelegate {func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.isHidden = true
    }
}
