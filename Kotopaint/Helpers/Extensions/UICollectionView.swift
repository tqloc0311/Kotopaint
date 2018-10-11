//
//  UICollectionView.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/3/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension UICollectionView {
    
    func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { (_) in
            completion()
        }
    }
    
    var centerPoint : CGPoint {
        
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y);
        }
    }
    
    var centerCellIndexPath: IndexPath? {
        
        if let centerIndexPath = self.indexPathForItem(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }
}
