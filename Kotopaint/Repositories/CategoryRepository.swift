//
//  CategoryRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/8/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CategoryRepository {
    
    // Static
    static let shared = CategoryRepository()
    
    // Properties
    var storage = [Category]()
    
    // Methods
    
    func loadData(completion: @escaping ([Category])->()) {
        let url = Globals.HOST + "categories?token=" + Globals.TOKEN
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
}
