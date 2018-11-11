//
//  APICache.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 11/11/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import RealmSwift

class APICache: Object {
    @objc dynamic var key = ""
    @objc dynamic var jsonString = ""
}
