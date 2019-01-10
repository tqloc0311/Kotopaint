//
//  PaintCalculator.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

class PaintCalculator {
    
    enum Construct: Int {
        case noithat = 0
        case ngoaithat = 1
    }
    
    enum Step2Mode: Int {
        case total = 0
        case parts = 1
    }
    
    // Properties
    var construct = Construct.noithat
    var layout = 1
    var step2Mode = Step2Mode.total
    var area = 1
    var long = 1
    var height = 1
    var width = 1
    var floor = 1
    var products = [Product]()
}
