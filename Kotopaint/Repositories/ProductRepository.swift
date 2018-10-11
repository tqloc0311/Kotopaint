//
//  ProductRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/8/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

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
    
    func loadData(completion: @escaping ([Product])->()) {
        executeOnBackground(task: {
            
        }, completion: {
            self.storage = self.loadDummy()
            completion(self.storage)
        }, delay: 0.2)
    }
    
    func getBy(categoryId: Int, completion: @escaping ([Product])->()) {
        executeOnBackground(task: {
            
        }, completion: {
            completion(self.loadDummy())
        }, delay: 0.2)
    }
}
