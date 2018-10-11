//
//  FaqRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 1/9/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation
import SwiftyJSON

class FaqRepository {
    
    // Static
    static let shared = FaqRepository()
    
    // Properties
    var storage = [FaqItem]()
    
    // Methods
    func loadData(completion: @escaping ([FaqItem])->()) {
        completion(loadDummy())
    }
    
    private func loadDummy() -> [FaqItem] {
        var result = [FaqItem]()
        let json = readFile()
        for item in json["data"].arrayValue {
            let id = item["id"].intValue
            let name = item["name"].stringValue
            let content = item["content"].stringValue
            result.append(FaqItem(id: id, title: name, content: content))
        }
//        for i in 1...20 {
//            let id = i
//            let name = "Question \(i)"
//            let content = "Answer \(i)"
//            result.append(FaqItem(id: id, title: name, content: content))
//        }
        
        return result
    }
    
    private func readFile() -> JSON {
        do {
            if let file = Bundle.main.url(forResource: "faqs", withExtension: "json") {
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
