//
//  APICacheManager.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 11/11/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class APICacheManager {
    
    static let shared = APICacheManager()
    
    var realm: Realm
    
    func set(key: String, json: JSON) {
        do {
            let item = APICache()
            item.key = key
            item.jsonString = json.description
            
            try realm.write {
                realm.add(item, update: true)
            }
        }
        catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    func get(key: String) -> JSON? {
        let predicate = NSPredicate(format: "key = %@", key)
        if let item = realm.objects(APICache.self).filter(predicate).first,
            item.jsonString != ""
        {
            let json = JSON.init(parseJSON: item.jsonString)
            return json
        }
        else {
            return nil
        }
    }
    
    init() {
        realm = try! Realm()
    }
}
