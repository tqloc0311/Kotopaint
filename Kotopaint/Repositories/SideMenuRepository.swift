//
//  SideMenuRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

class SideMenuRepository {
    
    // MARK: - Shared instance
    static let shared = SideMenuRepository()
    
    // MARK: - Properties
    var storage = [SideMenuItem]()
    
    // MARK: - Methods
    func loadData() {
        storage.removeAll()
        
        storage.append(SideMenuItem(id: 0, title: "Về chúng tôi", icon: #imageLiteral(resourceName: "about_side_menu")))
        storage.append(SideMenuItem(id: 1, title: "Đối tác", icon: #imageLiteral(resourceName: "contract_side_menu")))
        storage.append(SideMenuItem(id: 2, title: "Sản phẩm", icon: #imageLiteral(resourceName: "product_side_menu")))
        storage.append(SideMenuItem(id: 3, title: "Bảng màu", icon: #imageLiteral(resourceName: "colors_side_menu")))
        storage.append(SideMenuItem(id: 4, title: "Phối màu", icon: #imageLiteral(resourceName: "color_mix_side_menu")))
        storage.append(SideMenuItem(id: 5, title: "Tính sơn", icon: #imageLiteral(resourceName: "calculator_side_menu")))
        storage.append(SideMenuItem(id: 6, title: "Phong thủy", icon: #imageLiteral(resourceName: "ying_yang_side_menu")))
        storage.append(SideMenuItem(id: 7, title: "Hỏi đáp", icon: #imageLiteral(resourceName: "faq_side_menu")))
        storage.append(SideMenuItem(id: 8, title: "Liên hệ", icon: #imageLiteral(resourceName: "contact_side_menu")))
    }
    
    // MARK: - Constructors
    init() {
        loadData()
    }
}
