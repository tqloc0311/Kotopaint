//
//  FaqItem.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/9/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class FaqItem {
    
    // MARK: - Properties
    var id = 0
    var question = ""
    var answer = ""
    
    // Constructors
    init() {
        
    }
    
    init(id: Int, question: String, answer: String) {
        self.id = id
        self.question = question
        self.answer = answer
    }
}
