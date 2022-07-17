//
//  Datum.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import Foundation

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
