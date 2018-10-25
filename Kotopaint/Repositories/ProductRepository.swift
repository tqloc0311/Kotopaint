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
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    func loadData(categoryId: Int, completion: @escaping ([Product])->()) {
        let url = Globals.HOST + "products/\(categoryId)?token=" + Globals.TOKEN
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                let result = data.arrayValue.compactMap({ Product(json: $0) })
                completion(result.sorted(by: { $0.order < $1.order }))
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func loadData(categoryArray: [Int], completion: @escaping ([Product])->()) {
        let group = DispatchGroup()
        var result = [Product]()
        
        for id in categoryArray {
            group.enter()
            loadData(categoryId: id) { (list) in
                for item in list {
                    item.categoryId = id
                }
                
                result.append(contentsOf: list)
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(result)
        }
    }
}
