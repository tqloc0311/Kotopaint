//
//  PaintCalculatorRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PaintCalculatorRepository {
    
    // MARK: - Shared instance
    static let shared = PaintCalculatorRepository()
    
    // MARK: - Properties
    
    // MARK: - Methods
    private func productsToJSON(_ products: [Product]) -> JSON {
        if products.count == 0 {
            return JSON.null
        }
        var result: JSON = [:]
        var array = [JSON]()
        for item in products {
            var tmp: JSON = [:]
            
            tmp["id"].int = item.id
            tmp["categories"].int = item.categoryID
            
            array.append(tmp)
        }
        
        result.arrayObject = array
        return result
    }
    
    func calculate(_ item: PaintCalculator, completion: @escaping (String, PaintCalculatorResult?)->()) {
        let url = Globals.HOST + "calculatepaint?token=" + Globals.TOKEN
        let parameters: Parameters = [
            "construct": item.construct.rawValue,
            "layout": item.layout,
            "product": productsToJSON(item.products).description,
            "acreage": item.area,
            "rad_acreage": item.step2Mode.rawValue,
            "long": item.long,
            "height": item.height,
            "width": item.width,
            "floor": item.floor,
            ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil
            ).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let errorCode = json["error_code"].stringValue
                    let errorMessage = json["error_msg"].stringValue
                    if errorCode != "0" {
                        completion(errorMessage, nil)
                    }
                    else {
                        completion("", PaintCalculatorResult(json: json))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(error.localizedDescription, nil)
                }
        }
    }
    
    // MARK: - Constructors
}

