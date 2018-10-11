//
//  MenuCell.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell, ReusableView {
    
    // Properties
    var menuItem = SideMenuItem()
    var selectAction: (()->())?

    // Outlets
    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    // Methods
    func configure(data: SideMenuItem) {
        self.menuItem = data
        lblMenuName.text = data.title
        imgIcon.image = data.icon
    }
    
    func select() {
        if let f = selectAction {
            f()
        }
    }
    
    func highlight(_ bool: Bool) {
        imgIcon.image = menuItem.icon
        if bool {
            self.contentView.backgroundColor = (0xE7EAFF).toUIColor()
            lblMenuName.font = UIFont.systemFont(ofSize: lblMenuName.font.pointSize, weight: .bold)
        }
        else {
            self.contentView.backgroundColor = .white
            lblMenuName.font = UIFont.systemFont(ofSize: lblMenuName.font.pointSize, weight: .regular)
        }
    }
    
    // Overrides
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlight(true)
        select()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlight(false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlight(false)
    }
}
