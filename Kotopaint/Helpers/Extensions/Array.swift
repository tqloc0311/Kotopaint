//
//  Array.swift
//  DrVisualProject
//
//  Created by ProStageVN on 10/2/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

extension Array
{
    
    mutating func removeIf(_ closure:((Element) -> Bool)) {
        
        for i in (0..<self.count).reversed() {
            
            if closure(self[i]) {
                
                self.remove(at: i)
            }
        }
    }
    
    func random() -> Element {
        let count = self.count
        let randomIndex: Int = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
}
