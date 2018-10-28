//
//  PhongThuyRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 10/25/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PhongThuyRepository {
    
    // Static
    static let shared = PhongThuyRepository()
    
    // Properties
    private let css = """
<!-- Bootstrap Core CSS -->
    <link href="https://kotopaint.vn/application/views/orange/assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="https://kotopaint.vn/application/views/orange/assets/css/style.css" rel="stylesheet">
    <link href="https://kotopaint.vn/application/views/orange/assets/css/default.css" rel="stylesheet">
    <link href="https://kotopaint.vn/application/views/orange/assets/css/phoimaustyle.css" rel="stylesheet">
    <link href="https://kotopaint.vn/application/views/orange/assets/css/theme.css" rel="stylesheet">
"""
    
    // Methods
    func loadData(birthday: Date, direction: PhongThuy.Direction, gender: PhongThuy.Gender, completion: @escaping (String, String)->()) {
        let url = Globals.HOST + "phongthuy?token=" + Globals.TOKEN
        let parameters = [
            "day": birthday.day,
            "month": birthday.month,
            "year": birthday.year,
            ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil
            ).responseJSON { [unowned self] (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let errorCode = json["error_code"].stringValue
                    let errorMessage = json["error_msg"].stringValue
                    if errorCode != "0" {
                        completion(errorMessage, "")
                    }
                    else if let data = json["data"].string {
//                        print(self.css + data)
                        completion("", (self.css + data))
                    }
                    else {
                        completion("Unknown error", "")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(error.localizedDescription, "")
                }
        }
    }
}
