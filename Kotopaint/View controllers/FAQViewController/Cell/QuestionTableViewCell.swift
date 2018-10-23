//
//  QuestionTableViewCell.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/23/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import UIKit
import LUExpandableTableView

class QuestionTableViewCell: LUExpandableTableViewSectionHeader, ReusableView {

    // MARK: - Properties
    @IBOutlet weak var collapseImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    override var isExpanded: Bool {
        didSet {
            collapseImageView.image = isExpanded ? #imageLiteral(resourceName: "collapse_arrow") : #imageLiteral(resourceName: "expand_arrow")
        }
    }
    
    // MARK: - Methods
    func configure(question: String) {
        questionLabel.text = question
    }
    
    // MARK: - Base Class Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        self.isUserInteractionEnabled = true
    }
    
    // MARK: - Private Functions
    
    @objc private func didTap(_ sender: UIGestureRecognizer) {
        // Send the message to his delegate that was selected
        delegate?.expandableSectionHeader(self, shouldExpandOrCollapseAtSection: section)
    }
}
