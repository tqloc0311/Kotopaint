//
//  NewsRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/16/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsRepository {
    
    // Static
    static let shared = NewsRepository()
    
    // MARK: - Properties
    var storage = [News]()
    
    // MARK: - Methods
    func loadData(completion: @escaping ([News])->()) {
        storage = loadDummy()
        completion(storage)
    }
    
    private func loadDummy() -> [News] {
        var result = [News]()
        let json = readFile()
        for item in json["data"].arrayValue {
            let id = item["id"].intValue
            let name = item["name"].stringValue
            let shortContent = item["short_content"].stringValue
            let content = item["content"].stringValue
            let imagePath = item["img"].stringValue
            let file = (imagePath as NSString).lastPathComponent
            let fileName = (file as NSString).deletingPathExtension
            let image = UIImage(named: fileName) ?? #imageLiteral(resourceName: "news")
            result.append(News(id: id, name: name, shortContent: shortContent, content: content, imageUrl: imagePath, image: image))
        }
        
        return result
    }
    
    private func readFile() -> JSON {
        do {
            if let file = Bundle.main.url(forResource: "news", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = JSON(data)
                return json
            } else {
                print("no file")
                return JSON.null
            }
        } catch {
            print(error.localizedDescription)
            return JSON.null
        }
    }
}
