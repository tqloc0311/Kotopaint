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
            tmp["categories"].int = item.categoryId
            
            array.append(tmp)
        }
        
        result.arrayObject = array
        print(result.description)
        return result
    }
    
    func calculate(_ item: PaintCalculator, completion: @escaping (String, NSAttributedString)->()) {
        let url = Globals.HOST + "calculatepaint?token=" + Globals.TOKEN
        var parameters: Parameters = [
            "construct": item.construct.rawValue,
            "layout": item.layout,
            "product": productsToJSON(item.products).description,
            ]
        if item.step2Mode == .total {
            parameters["acreage"] = item.area
            parameters["rad_acreage"] = item.area
        }
        else {
            parameters["long"] = item.long
            parameters["height"] = item.height
            parameters["width"] = item.width
            parameters["floor"] = item.floor
        }
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil
            ).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let errorCode = json["error_code"].stringValue
                    let errorMessage = json["error_msg"].stringValue
                    if errorCode != "0" {
                        completion(errorMessage, NSAttributedString())
                    }
                    else {
                        let data = json["data"]
                        
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(error.localizedDescription, NSAttributedString())
                }
        }
    }
    
    // MARK: - Constructors
}

