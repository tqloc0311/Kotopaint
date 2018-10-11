//
//  VideoRepository.swift
//  Kotopaint
//
//  Created by ProStageVN on 2/6/18.
//  Copyright © 2018 FREELANCE. All rights reserved.
//

import Foundation

class VideoRepository {
    
    // Static
    static let shared = VideoRepository()
    
    // Properties
    var data = [VideoModel]()
    
    // Methods
    func loadData() {
        data.removeAll()
        data.append(VideoModel(id: 1, url: "https://www.youtube.com/watch?v=7w_8Z-D1iNE", title: "Giới thiệu Công Ty Sơn Koto Việt Nam", image: #imageLiteral(resourceName: "video")))
        data.append(VideoModel(id: 2, url: "https://www.youtube.com/watch?v=7w_8Z-D1iNE", title: "Giới thiệu Công Ty Sơn Koto Việt Nam", image: #imageLiteral(resourceName: "video")))
        data.append(VideoModel(id: 3, url: "https://www.youtube.com/watch?v=7w_8Z-D1iNE", title: "Giới thiệu Công Ty Sơn Koto Việt Nam", image: #imageLiteral(resourceName: "video")))
        data.append(VideoModel(id: 4, url: "https://www.youtube.com/watch?v=7w_8Z-D1iNE", title: "Giới thiệu Công Ty Sơn Koto Việt Nam", image: #imageLiteral(resourceName: "video")))
        data.append(VideoModel(id: 5, url: "https://www.youtube.com/watch?v=7w_8Z-D1iNE", title: "Giới thiệu Công Ty Sơn Koto Việt Nam", image: #imageLiteral(resourceName: "video")))
        data.append(VideoModel(id: 6, url: "https://www.youtube.com/watch?v=7w_8Z-D1iNE", title: "Giới thiệu Công Ty Sơn Koto Việt Nam", image: #imageLiteral(resourceName: "video")))
    }
}
