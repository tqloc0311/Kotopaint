//
//  AnswerTableViewCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/23/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell, ReusableView {

    // MARK: - Outlets
    @IBOutlet weak var answerLabel: UILabel!
    
    // MARK: - Methods
    func configure(answer: String) {
        answerLabel.text = answer
    }
}
