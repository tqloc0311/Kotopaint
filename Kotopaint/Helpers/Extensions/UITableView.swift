//
//  UICollectionView.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/3/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension UITableView {
    func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { (_) in
            completion()
        }
    }
}
