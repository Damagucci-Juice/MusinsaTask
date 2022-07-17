//
//  Extension +.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/15.
//

import UIKit

protocol Informable {
    associatedtype Item
    func setUpInformations(_ product: Item)
    func loadImage(_ urlString: String)
}

protocol Displayable {
    var linkURL: String { get set }
    var thumbnailURL: String { get set }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
