//
//  PhoiMauResultRepository.swift
//  Kotopaint
//
//  Created by Tran Quoc Loc on 10/29/18.
//  Copyright © 2018 Stage Group. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhoiMauResultRepository {
    
    // Static
    static let shared = PhoiMauResultRepository()
    
    // Methods
    private func saveImageToLocal(id: String, image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return nil
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return nil
        }
        let path = directory.appendingPathComponent("\(id).png")!
        do {
            try data.write(to: path)
            return path.relativeString
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func save(item: PhoiMauResult) {
        if let path = saveImageToLocal(id: item.id, image: item.image!) {
            var json = JSON(
                [
                    "id": item.id,
                    "image": path,
                ])
            json["color_items"].arrayObject = item.selectedColorItem.compactMap({ $0.toJSON() })
//            for (index, tmp) in item.selectedColorItem.enumerated() {
//                json["color_items"].array?.append(tmp.toJSON())
//            }
            if LocalStorage.sharedInstance.content["saved_phoi_mau"] == JSON.null {
                LocalStorage.sharedInstance.content["saved_phoi_mau"] = [:]
            }
            LocalStorage.sharedInstance.content["saved_phoi_mau"][item.id] = json
            LocalStorage.sharedInstance.update()
        }
    }
    
    func loadData() -> [PhoiMauResult] {
        var result = [PhoiMauResult]()
        let json = LocalStorage.sharedInstance.content
        result = json["saved_phoi_mau"].dictionaryValue.compactMap({ PhoiMauResult(json: $0.value) })
        return result
    }
}
