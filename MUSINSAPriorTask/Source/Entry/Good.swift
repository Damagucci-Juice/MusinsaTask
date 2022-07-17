//
//  Good.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import Foundation

// MARK: - Good
struct Good: Codable, Displayable {
    var linkURL: String
    var thumbnailURL: String
    let brandName: BrandName
    let price, saleRate: Int
    let hasCoupon: Bool
}
