//
//  Banner.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import Foundation

// MARK: - Banner
struct Banner: Codable, Displayable {
    var linkURL: String
    var thumbnailURL: String
    let title, bannerDescription, keyword: String

    enum CodingKeys: String, CodingKey {
        case linkURL, thumbnailURL, title
        case bannerDescription = "description"
        case keyword
    }
}
