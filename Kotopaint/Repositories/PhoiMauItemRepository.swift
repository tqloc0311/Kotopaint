//
//  PhoiMauItemRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/26/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PhoiMauItemRepository {
    
    // MARK: - Shared instance
    static let shared = PhoiMauItemRepository()
    
    // MARK: - Properties
    
    // MARK: - Methods
    
    func loadData(categoryID: Int, completion: @escaping ([PhoiMauItem])->()) {
        let url = Globals.HOST + "phoimaus/\(categoryID)?token=" + Globals.TOKEN
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                let result = data.dictionaryValue.compactMap({ PhoiMauItem(json: $0.value) })
                completion(result)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    // MARK: - Constructors
}

