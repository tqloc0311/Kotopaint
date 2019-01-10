//
//  VideoRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/6/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VideoRepository {
    
    // Static
    static let shared = VideoRepository()
    
    // MARK: - Properties
    var storage = [VideoModel]()
    
    // MARK: - Methods
    func loadData(completion: @escaping ([VideoModel])->()) {
        let url = APIHelper.HOST + "posts/7?token=" + APIHelper.TOKEN
        Alamofire.request(url).responseJSON { [weak self] (response) in
            guard let self = self else { return }
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
                    self.storage = data.arrayValue.compactMap({ VideoModel(json: $0) })
                    completion(self.storage)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
        }
    }
}
