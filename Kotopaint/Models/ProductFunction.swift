
//
//  ProductFunction.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/8/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class ProductFunction {
    
    // MARK: - Properties
    var id = 0
    var name = ""
    var imageUrl = ""
    var image: UIImage?
    
    // Constructors
    init() {
        
    }
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    // Static
//    static func getBy(keyword: String) -> ProductFunction {
//        switch keyword {
//        case "bam-dinh-tot":
//            return ProductFunction(content: "Bám dính tốt", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "Bảo vệ 8 năm", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "Bề mặt trơn láng", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "Che lấp vết nứt nhỏ", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "Chống bong tróc", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "Chóng tia UV", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "Dễ", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        case "<#pattern#>":
//            return ProductFunction(content: "<#T##String#>", image: <#T##UIImage#>)
//        default:
//            return ProductFunction()
//        }
//    }
}
