//
//  APISessionHelper.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 11/11/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIHelper {
    
    // Shared
    
    // Properties
    static let HOST = "http://api.kotopaint.vn/"
    static var TOKEN = ""
    
    enum APICallingMode {
        case online
        case offline
    }
    
    // Methods
    static func requestToken(completion: @escaping (Bool)->()) {
        let url = APIHelper.HOST + "auth/login"
        let body = [
            "email": "nguyenvietduckt82@gmail.com",
            "password": "123456",
            ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let token = json["token"].string else {
                    print("token does not exist")
                    completion(false)
                    return
                }
                
                APIHelper.TOKEN = token
                print(APIHelper.TOKEN)
                completion(true)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
                break
            }
        }
    }
    
    static func validateToken(completion: @escaping (Bool)->()) {
        requestToken { (success) in
            completion(success)
        }
    }
}
