//
//  Section.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/13.
//

import Foundation

// MARK: - Products
struct Section: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let contents: Contents
    let header: Header?
    let footer: Footer?
    
    init() {
        self.contents = Contents(type: "samle", banners: nil, goods: nil, styles: nil)
        self.header = nil
        self.footer = nil
    }
}

// MARK: - Contents
struct Contents: Codable {
    let type: String
    let banners: [Banner]?
    let goods: [Good]?
    let styles: [Style]?
}

// MARK: - Banner
struct Banner: Codable, Displayable {
    let linkURL: String
    let thumbnailURL: String
    let title, bannerDescription, keyword: String

    enum CodingKeys: String, CodingKey {
        case linkURL, thumbnailURL, title
        case bannerDescription = "description"
        case keyword
    }
}

// MARK: - Good
struct Good: Codable, Displayable {
    let linkURL: String
    let thumbnailURL: String
    let brandName: BrandName
    let price, saleRate: Int
    let hasCoupon: Bool
}

// MARK: - 나중에 문제 생길 수 있음
enum BrandName: String, Codable {
    case discoveryExpadition = "디스커버리 익스페디션"
    case astralProjection = "아스트랄 프로젝션"
    case tenBlade = "텐블레이드"
}

// MARK: - Style
struct Style: Codable, Displayable {
    let linkURL: String
    let thumbnailURL: String
}

// MARK: - Footer
struct Footer: Codable {
    let type, title: String
    let iconURL: String?
}

// MARK: - Header
struct Header: Codable {
    let title: String
    let iconURL: String?
    let linkURL: String?
}

enum SectionType {
    case banner, grid, scroll, style
    
    static func convert(_ section: Int) -> Self? {
        switch section {
        case 0:
            return .banner
        case 1:
            return .grid
        case 2:
            return .scroll
        case 3:
            return .style
        default:
            return nil
        }
    }
}
