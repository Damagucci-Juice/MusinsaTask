//
//  SectionType.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import Foundation

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
