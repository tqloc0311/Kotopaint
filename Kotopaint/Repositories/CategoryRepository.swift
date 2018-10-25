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
    
    // MARK: - Properties
    var storage = [Category]()
    
    // MARK: - Methods
    
    func loadData(completion: @escaping ([Category])->()) {
        let url = Globals.HOST + "categories?token=" + Globals.TOKEN
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                let result = data.arrayValue.compactMap({ Category(json: $0) })
                let topCategories = result.filter({ $0.parentId == 0 })
                let subCategories = result.filter({ $0.parentId > 0 })
                for top in topCategories {
                    for sub in subCategories {
                        if sub.parentId == top.id {
                            top.child.append(sub)
                        }
                    }
                }
                completion(topCategories)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getChildCategoryOf(categoryId: Int, completion: @escaping ([Category])->()) {
        loadData { (all) in
            if let found = all.first(where: { $0.id == categoryId }) {
                completion(found.child)
            }
            else {
                completion([])
            }
        }
    }
}
