//
//  ProductRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/8/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductRepository {
    
    // Static
    static let shared = ProductRepository()
    
    // Properties
    var storage = [Product]()
    
    // Methods
    func loadDummy() -> [Product] {
        var result = [Product]()
        
        for i in 1...11 {
            let product = Product.dummy()
            product.id = i
            result.append(product)
        }
        
        return result
    }
    
    func loadData(categoryId: Int, completion: @escaping ([Product])->()) {
        let url = Globals.HOST + "products/\(categoryId)?token=" + Globals.TOKEN
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                let result = data.arrayValue.compactMap({ Category(json: $0) })
                completion(result.sorted(by: { $0.order < $1.order }))
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getBy(categoryId: Int, completion: @escaping ([Product])->()) {
        executeOnBackground(task: {
            
        }, completion: {
            completion(self.loadDummy())
        }, delay: 0.2)
    }
}
