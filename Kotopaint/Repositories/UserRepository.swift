//
//  UserRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/11/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserRepository {
    
    // MARK: - Constants
    
    // MARK: - Shared instance
    static let shared = UserRepository()
    
    // MARK: - Properties
    
    // MARK: - Methods
    func login(completion: @escaping (Bool)->()) {
        let url = Globals.HOST + "auth/login"
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
                
                Globals.TOKEN = token
                print(Globals.TOKEN)
                completion(true)
                break
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
                break
            }
        }
    }
    
    // MARK: - Constructors
}

