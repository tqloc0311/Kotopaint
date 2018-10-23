//
//  ContactViewController.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import GoogleMaps
import ActionKit

class ContactViewController: BackButtonViewController {
    
    // MARK: - Properties
    var panGesture: UIPanGestureRecognizer!
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnDirection: UIButton!
    
    // MARK: - Actions
    @IBAction func getDirection(_ sender: Any) {
        guard let url = URL(string: "https://www.google.com/maps/dir//21.006584,105.801849/@21.006584,105.801849,14z?hl=vi-VN") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    // MARK: - Methods
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if let isRight = recognizer.isLeftToRight(view), isRight {
            didBack()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Thông tin liên hệ"
        
        let coordinate = CLLocationCoordinate2D(latitude: 21.006584, longitude: 105.801849)
        self.mapView.camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        let marker = GMSMarker(position: coordinate)
        marker.title = "Kotopaint"
        marker.appearAnimation = .pop
        marker.map = self.mapView
        
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        mapView.delegate = self
        
        scrollView.delaysContentTouches = false
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: mapView.frame.maxY + 20)
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
extension ContactViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: - GMSMapViewDelegate
extension ContactViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.view.removeGestureRecognizer(panGesture)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.view.addGestureRecognizer(panGesture)
    }
}
