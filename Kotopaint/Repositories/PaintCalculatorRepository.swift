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
    var categories: [PaintCalculatorCategory] = []
    
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
    
    private func productsToJSONV2(_ products: [PaintCalculatorProduct]) -> JSON {
        if products.count == 0 {
            return JSON.null
        }
        var result: JSON = [:]
        var array = [JSON]()
        for item in products {
            var tmp: JSON = [:]
            
            tmp["id"].int = item.id
            tmp["parent"].int = item.categoryID
            tmp["solop"].int = item.numOfLayers
            
            array.append(tmp)
        }
        
        result.arrayObject = array
        return result
    }
    
    func getAllProducts(completion: @escaping ([PaintCalculatorCategory])->()) {
        let url = APIHelper.HOST + "getallproduct?token=" + APIHelper.TOKEN
        Alamofire.request(url).responseJSON { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let errorCode = json["error_code"].stringValue
                if errorCode == "3000" || errorCode == "3002" {
                    APIHelper.requestToken(completion: { (_) in
                        self.getAllProducts(completion: completion)
                    })
                }
                else {
                    let data = json["data"]
                    self.categories = data.arrayValue.compactMap({ PaintCalculatorCategory(json: $0) })
                    completion(self.categories)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
    
    func calculate(_ item: PaintCalculator, completion: @escaping (String, PaintCalculatorResult?)->()) {
        let url = APIHelper.HOST + "calculatepaint?token=" + APIHelper.TOKEN
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
                    if errorCode == "3000" || errorCode == "3002" {
                        APIHelper.requestToken(completion: { (_) in
                            self.calculate(item, completion: completion)
                        })
                    }
                    else if errorCode != "0" {
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
    
    func calculateV2(long: Int, width: Int, height: Int, numOfFloors: Int, colorSurfaces: Int, waterproofingSurfaces: Int, products: [PaintCalculatorProduct], completion: @escaping (String, PaintCalculatorResultV2?)->()) {
        let url = APIHelper.HOST + "calculatepaintv2?token=" + APIHelper.TOKEN
        let parameters: Parameters = [
            "long": long,
            "height": height,
            "width": width,
            "floor": numOfFloors,
            "layout": colorSurfaces,
            "chongtham": waterproofingSurfaces,
            "products": productsToJSONV2(products).description,
            ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil
            ).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let errorCode = json["error_code"].stringValue
                    let errorMessage = json["error_msg"].stringValue
                    if errorCode == "3000" || errorCode == "3002" {
                        APIHelper.requestToken(completion: { (_) in
                            self.calculateV2(long: long, width: width, height: height, numOfFloors: numOfFloors, colorSurfaces: colorSurfaces, waterproofingSurfaces: waterproofingSurfaces, products: products, completion: completion)
                        })
                    }
                    else if errorCode != "0" {
                        completion(errorMessage, nil)
                    }
                    else {
                        completion("", PaintCalculatorResultV2(json: json))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(error.localizedDescription, nil)
                }
        }
    }
    
    // MARK: - Constructors
}

