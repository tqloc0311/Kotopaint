//
//  CheckBoxButton.swift
//  ThanhDuoc
//
//  Created by ProStageVN on 10/24/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import UIKit

protocol CheckBoxButtonDelegate {
    func checkBoxDidChange(checkBox: CheckBoxButton, value: Bool, object: Any?)
}

class CheckBoxButton: ImageButton {
    
    typealias EventHandler = (Bool)->()
    
    // MARK: - Properties
    var uncheckedImage: UIImage?
    var checkedImage: UIImage?
    
    var delegate: CheckBoxButtonDelegate?
    
    var checked = false {
        didSet {
            image = checked ? checkedImage : uncheckedImage
            delegate?.checkBoxDidChange(checkBox: self, value: checked, object: object)
        }
    }
    
    var object: Any?
    
    // MARK: - Constructor
    init(frame: CGRect, uncheckedImage: UIImage, checkedImage: UIImage) {
        self.uncheckedImage = uncheckedImage
        self.checkedImage = checkedImage
        super.init(frame: frame)
        
        image = uncheckedImage
        
        touchUpInsideAction = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.checked = !self.checked
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        image = uncheckedImage
        
        touchUpInsideAction = { [weak self] in
            guard let self = self else {
                return
            }
            
            self.checked = !self.checked
        }
    }
}
