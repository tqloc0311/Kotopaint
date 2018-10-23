//
//  UIPanGestureRecognizer.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension UIPanGestureRecognizer {
    
    func isLeftToRight(_ theViewYouArePassing: UIView) -> Bool? {
        let detectionLimit: CGFloat = 1000
        let _velocity : CGPoint = velocity(in: theViewYouArePassing)
        
        //        print("velocity: \(_velocity)")
        if _velocity.x > detectionLimit {
            //            print("Gesture went right")
            return true
        } else if _velocity.x < -detectionLimit {
            //            print("Gesture went left")
            return false
        }
        
        return nil
    }
}
