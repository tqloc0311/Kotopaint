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
    
    //  MARK: - Constants
    
    //  MARK: - Properties
    var panGesture: UIPanGestureRecognizer!
    
    //  MARK: - Outlets
    @IBOutlet weak var mapView: GMSMapView!
    
    //  MARK: - Actions
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
    
    //  MARK: - Methods
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func panHandle(_ recognizer:UIPanGestureRecognizer) {
        if let isRight = recognizer.isRight(view), isRight {
            back()
        }
    }
    
    func setupView() {
        hero.isEnabled = true
        self.navigationItem.titleView?.hero.id = "contactTitle"
        self.navigationItem.title = "Thông tin liên hệ"
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        panGesture.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(panGesture)
        
    }
    
    func setupGoogleMap() {
        let coordinate = CLLocationCoordinate2D(latitude: 21.006584, longitude: 105.801849)
        self.mapView.camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        let marker = GMSMarker(position: coordinate)
        marker.title = "Kotopaint"
        marker.appearAnimation = .pop
        marker.map = self.mapView
        
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        mapView.delegate = self
    }
    
    //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupGoogleMap()
    }
}

//  MARK: - UIGestureRecognizerDelegate
extension ContactViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//  MARK: - GMSMapViewDelegate
extension ContactViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.view.removeGestureRecognizer(panGesture)
        
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.view.addGestureRecognizer(panGesture)
    }
}
