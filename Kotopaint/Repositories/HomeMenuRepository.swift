//
//  SideMenuRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/10/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation

class HomeMenuRepository {
    
    // MARK: - Shared instance
    static let shared = HomeMenuRepository()
    
    // MARK: - Properties
    var storage = [HomeMenuItem]()
    
    // MARK: - Methods
    func loadData() {
        storage.removeAll()
        
        // Bộ sưu tập màu
        var item = HomeMenuItem(id: 0, title: "Bộ sưu tập màu", titleHeroID: "colorTitle", subTitle: "Các màu cho dự án của tôi", photo: #imageLiteral(resourceName: "color_galery"), bottomTitle: "Xem thêm màu...")
        item.shadow = false
        storage.append(item)
        //
        
        // Sản phẩm
        item = HomeMenuItem(id: 1, title: "Tất cả sản phẩm", titleHeroID: "productTitle", subTitle: "Mọi thứ bạn cần", photo: #imageLiteral(resourceName: "all_product"), bottomTitle: "Xem thêm sản phẩm...")
        storage.append(item)
        //
        
        // Ý tưởng
        item = HomeMenuItem(id: 2, title: "Ý tưởng", titleHeroID: "ideaTitle", subTitle: "Gợi ý màu và xu hướng", photo: #imageLiteral(resourceName: "idea"))
        storage.append(item)
        //
        
        // Video
        item = HomeMenuItem(id: 3, title: "Video", titleHeroID: "videoTitle", subTitle: "Các video tham khảo", photo: #imageLiteral(resourceName: "video"))
        storage.append(item)
        //
        
        // Phối màu
        item = HomeMenuItem(id: 4, title: "Phần mềm", titleHeroID: "colorSchemeTitle", subTitle: "phối màu", photo: #imageLiteral(resourceName: "color_scheme"))
        storage.append(item)
        //
        
        // Tính sơn
        item = HomeMenuItem(id: 5, title: "Tính sơn", titleHeroID: "paintCalcTitle", subTitle: "Phần mềm tính sơn", photo: #imageLiteral(resourceName: "paint_calc"))
        storage.append(item)
        //
        
        // Phong thủy
        item = HomeMenuItem(id: 6, title: "Phong thủy", titleHeroID: "phongthuyTitle", subTitle: "Chọn màu phong thủy", photo: #imageLiteral(resourceName: "phongthuy"))
        storage.append(item)
        //
        
        // Liên hệ
        item = HomeMenuItem(id: 7, title: "Liên hệ", titleHeroID: "contactTitle", subTitle: "Liên hệ với chúng tôi", photo: #imageLiteral(resourceName: "contact"))
        item.shadow = false
        storage.append(item)
    }
    
    // MARK: - Constructors
    init() {
        loadData()
    }
}
