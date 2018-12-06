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
    
    func loadData(categoryID: Int, mode: APIHelper.APICallingMode = .online, completion: @escaping ([Product])->()) {
        
        if mode == .online {
            let url = APIHelper.HOST + "products/\(categoryID)?token=" + APIHelper.TOKEN
            Alamofire.request(url).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let errorCode = json["error_code"].stringValue
                    if errorCode == "3000" || errorCode == "3002" {
                        APIHelper.requestToken(completion: { (_) in
                            self.loadData(categoryID: categoryID, completion: completion)
                        })
                    }
                    else {
                        let data = json["data"]
//                        APICacheManager.shared.set(key: "products/\(categoryID)", json: data)
                        let result = data.arrayValue.compactMap({ Product(json: $0) })
                        completion(result.sorted(by: { $0.order < $1.order }))
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([])
                }
            }
        }
        else {
            if let json = APICacheManager.shared.get(key: "products/\(categoryID)") {
                let result = json.arrayValue.compactMap({ Product(json: $0) })
                completion(result.sorted(by: { $0.order < $1.order }))
            }
            else {
                completion([])
            }
        }
    }
    
    func loadData(categoryArray: [Int], completion: @escaping ([Product])->()) {
        let group = DispatchGroup()
        var result = [Product]()
        
        for id in categoryArray {
            group.enter()
            loadData(categoryID: id) { (list) in
                for item in list {
                    item.categoryID = id
                }
                
                result.append(contentsOf: list)
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(result)
        }
    }
    
    func getBy(productID: Int, completion: @escaping (String, Product?)->()) {
        let url = APIHelper.HOST + "product/\(productID)?token=" + APIHelper.TOKEN
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let errorCode = json["error_code"].stringValue
                let errorMessage = json["error_msg"].stringValue
                
                if errorCode == "3000" || errorCode == "3002" {
                    APIHelper.requestToken(completion: { (_) in
                        self.getBy(productID: productID, completion: completion)
                    })
                }
                else if errorCode != "0" {
                    completion(errorMessage, nil)
                }
                else {
                    let data = json["data"]
                    
                    completion("", Product(json: data))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, nil)
            }
        }
    }
}
