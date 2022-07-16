//
//  MusinsaTarget.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/13.
//

import Foundation
import TinyNetworking

enum MusinsaTarget {
    case sections                   // https://meta.musinsa.com/interview/list.json
//    case icon                       // https://image.msscdn.net/icons/mobile/clock.png
//    case banner(id: String)         // https://image.msscdn.net/images/event_banner/2022062215240900000026699.jpg
//    case goods(id: String)          // https://image.msscdn.net/images/goods_img/20211224/2281818/2281818_1_320.jpg
//    case style(id: String)          // https://image.musinsa.com/images/style/list/2022062214124200000032093.jpg
//    case codimap(id: String)        // https://image.musinsa.com/images/codimap/list/2022062313464900000074853.jpg
//    case photo(url: URL)
}

// MARK: - init section request
extension MusinsaTarget: Resource {
    var baseURL: URL {
        switch self {
        case .sections:
            guard let url = URL(string: "https://meta.musinsa.com/interview") else {
                fatalError("FAILED: https://meta.musinsa.com/interview")
            }
            return url
        }
    }
    
    var endpoint: Endpoint {
        switch self {
        case .sections:
            return .get(path: "/list.json")
        }
    }
    
    var task: Task {
        let parms: [String: Any] = [:]
        return  .requestWithParameters(parms, encoding: URLEncoding())
    }
    
    var headers: [String : String] {
        return ["content-type": "application/json"]
    }
}
