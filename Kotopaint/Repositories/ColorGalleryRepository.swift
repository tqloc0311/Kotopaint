//
//  ColorGalleryRepository.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/24/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ColorGalleryRepository {
    
    // Static
    static let shared = ColorGalleryRepository()
    
    // Properties
    var storage = [ColorGallery]()
    
    // Methods
    func loadData(completion: @escaping (String, [ColorGallery])->()) {
        let url = Globals.HOST + "colors?token=" + Globals.TOKEN
        Alamofire.request(url).responseJSON { [unowned self] (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let errorCode = json["error_code"].stringValue
                let errorMessage = json["error_msg"].stringValue
                if errorCode != "0" {
                    completion(errorMessage, [])
                }
                else {
                    let data = json["data"]
                    let result = data.arrayValue.compactMap({ ColorGallery(json: $0) })
                    
                    self.storage = result
                    
                    completion("", result)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(error.localizedDescription, [])
            }
        }
    }
}
