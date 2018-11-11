//
//  PhoiMauCategoryRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/26/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PhoiMauCategoryRepository {
    
    // MARK: - Shared instance
    static let shared = PhoiMauCategoryRepository()
    
    // MARK: - Properties
    
    // MARK: - Methods
    func loadData(completion: @escaping ([PhoiMauCategory])->()) {
        let url = APIHelper.HOST + "phoimaucategory?token=" + APIHelper.TOKEN
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let errorCode = json["error_code"].stringValue
                if errorCode == "3000" || errorCode == "3002" {
                    APIHelper.requestToken(completion: { (_) in
                        self.loadData(completion: completion)
                    })
                }
                else {
                    let data = json["data"]
                    let result = data.arrayValue.compactMap({ PhoiMauCategory(json: $0) })
                    let topCategories = result.filter({ $0.parentID == 0 })
                    let subCategories = result.filter({ $0.parentID > 0 })
                    for top in topCategories {
                        for sub in subCategories {
                            if sub.parentID == top.id {
                                top.child.append(sub)
                            }
                        }
                    }
                    completion(topCategories)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func getChildCategoryOf(parentID: Int, completion: @escaping ([PhoiMauCategory])->()) {
        loadData { (all) in
            if let found = all.first(where: { $0.id == parentID }) {
                completion(found.child)
            }
            else {
                completion([])
            }
        }
    }
    
    // MARK: - Constructors
}

