//
//  Contents.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import Foundation

// MARK: - Contents
struct Contents: Codable {
    let type: String
    let banners: [Banner]?
    let goods: [Good]?
    let styles: [Style]?
    
    subscript(_ sectionIndex: Int) -> [Displayable]? {
        switch sectionIndex {
        case 0:
            return banners
        case 1...2:
            return goods
        case 3:
            return styles
        default:
            return nil
        }
    }
}
