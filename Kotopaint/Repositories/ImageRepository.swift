//
//  ImageRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/6/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

enum ImageModelGroup {
    case ngoaithat
    case noithat
    case living
    case bed
    case dining
    case kids
}

class ImageRepository {
    
    // Static
    static let shared = ImageRepository()
    
    // MARK: - Properties
    var data = [ImageModel]()
    
    // MARK: - Methods
    func getByGroup(_ group: ImageModelGroup) -> [ImageModel] {
        switch group {
        case .ngoaithat:
            return data.filter({$0.index >= 1 && $0.index <= 10})
        case .noithat:
            return data.filter({$0.index >= 11 && $0.index <= 50})
        case .living:
            return data.filter({$0.index >= 11 && $0.index <= 20})
        case .bed:
            return data.filter({$0.index >= 21 && $0.index <= 30})
        case .dining:
            return data.filter({$0.index >= 31 && $0.index <= 40})
        case .kids:
            return data.filter({$0.index >= 41 && $0.index <= 50})
        }
    }
    
    func loadData() {
        data.removeAll()
        for i in 1...10 {
            data.append(ImageModel(index: i, image: UIImage(named: "ngoaithat\(i)")!))
        }
        for i in 11...20 {
            data.append(ImageModel(index: i, image: UIImage(named: "living\(i-10)")!))
        }
        for i in 21...30 {
            data.append(ImageModel(index: i, image: UIImage(named: "bed\(i-20)")!))
        }
        for i in 31...40 {
            data.append(ImageModel(index: i, image: UIImage(named: "dining\(i-30)")!))
        }
        for i in 41...50 {
            data.append(ImageModel(index: i, image: UIImage(named: "kid\(i-40)")!))
        }
    }
    
    // Constructors
    init() {
        
    }
}
