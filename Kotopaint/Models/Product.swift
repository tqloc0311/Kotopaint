
//
//  Product.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/4/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import Fakery

class Product {
    
    // Properties
    var id = 0
    var name = ""
    var short_content = ""
    var content = ""
    
    var imageUrl = ""
    var image: UIImage?
    var libImageUrls: [String] = []
    var libImages = [UIImage]()
    
    var categoryIds = [Int]()
    
    // Detail information
    var surface = ""
    var coverage = 0
    var time = 0
    var layer = 0
    var confectionRatio = ""
    var preservation = ""
    
    // Product information
    var productInfo = ""
    var component = ""
    var notice = ""
    
    var functions = [ProductFunction]()
    var environmentInfo: [String] = []
    
    // Static
    static func dummy() -> Product {
        let dummy = Product()
        dummy.id = Faker().number.randomInt(min: 1000, max: 9999)
        dummy.name = "Sơn siêu trắng Ceilwhite"
        dummy.short_content = "Ceilwhite siêu trắng nội thất có chất lượng & độ bền cao, dùng trang trí và bảo vệ các bề mặt tường nội thất"
        dummy.image = #imageLiteral(resourceName: "son-trang-ceilwhite1")
        dummy.libImages = [#imageLiteral(resourceName: "son-trang-ceilwhite1"), #imageLiteral(resourceName: "son-trang-ceilwhite2"), #imageLiteral(resourceName: "son-trang-ceilwhite3")]
        dummy.categoryIds = [1]
        dummy.surface = "Bề mặt bóng mờ"
        dummy.coverage = 13
        dummy.time = 45
        dummy.layer = 2
        dummy.confectionRatio = "7% theo thể tích"
        dummy.preservation = "Đậy chặt nắp thùng, bảo quản nơi thoáng mát"
        dummy.productInfo = "Ceilwhite siêu trắng nội thất có chất lượng & độ bền cao, dùng trang trí và bảo vệ các bề mặt tường nội thất. Ceilewhite siêu trắng được sản xuất theo công nghệ tiên tiến, cho độ che phủ lấp cao và dễ thi công."
        dummy.component = "Nước nhựa Arylic bột khoáng nước, chất bền màu không chưa chì, thủy ngân."
        dummy.notice = """
        - Phải xử lý bề mặt có rêu mốc (Dùng hóa chất tẩy rửa và diệt rêu mốc)
        
        - Đảm bảo bề mặt cần sơn phải sạch, không có tạp chất làm giảm sự bám dính như bột, dầu mỡ hay sáp
        
        - Độ ẩm bề mặt sớn nhở hơn 16% theo máy đo độ ẩm Protiometer hay để bề mặt tường khô từ 21 - 28 ngày trong điều kiện bình thường 30oC, độ ẩm môi trường 80%
        
        - Lưu ý không dùng sơn trong điều kiện thời tiết ẩm ướt, nhiệt độ thi công dưới 10oC.
        
        - Dùng giấy nhám thích hợp để chà nhám sau đó quét sạch bụi. Sử dụng bột trét KOTO để có bề mặt nhẵn mịn.
        
        - Sơn lót 2 lớp để có bề mặt nhẵn mịn tăng độ kết dính và giữ màu sắc bền lâu.
        
        - Không nên pha quá nhiều nước, độ che lấp sẽ kém
"""
        var func1 = ProductFunction(name: "MÀNG SƠN TRẮNG SÁNG RẠNG RỠ", image: #imageLiteral(resourceName: "mang-son-trang-sang-rang-ro"))
        dummy.functions.append(func1)
        func1 = ProductFunction(name: "ĐỘ CHE PHỦ CAO", image: #imageLiteral(resourceName: "do-che-phu-cao"))
        dummy.functions.append(func1)
        func1 = ProductFunction(name: "BỀ MẶT TRƠN LÁNG", image: #imageLiteral(resourceName: "be-mat-tron-lang"))
        dummy.functions.append(func1)
        
        dummy.environmentInfo.append("Tránh tiếp xúc với da. Có thể gây dị ứng khi tiếp xúc với da.")
        dummy.environmentInfo.append("Gây hại cho sinh vật sống dưới nước. Có thể gây tác động có hại lâu dài cho môi trường sống dưới nước.")
        dummy.environmentInfo.append("Để xa tầm trẻ em. Tránh hít bụi sơn")
        dummy.environmentInfo.append("Mang găng tay thích hợp")
        dummy.environmentInfo.append("Chỉ sử dụng ở nơi thông thoáng")
        dummy.environmentInfo.append("Tránh thải sơn ra môi trường.")
        dummy.environmentInfo.append("Khi sơn nên mang kính bảo vệ mắt. Khi bị dính sơn vào mắt nên rửa với thật nhiều nước và đi đến Bác sỹ.")
        dummy.environmentInfo.append("Nếu nuốt phải nên đến gặp Bác sĩ ngay và mang theo thùng sơn hoặc nhãn sơn. Không đổ sơn vào cống rãnh hay nguồn nước.")
        dummy.environmentInfo.append("Trong trường hợp đổ sơn, nên thu gom bằng đất hoặc cát. Xem hướng dẫn trong thông tin An Toàn Sản Phẩm")
        return dummy
    }
}
