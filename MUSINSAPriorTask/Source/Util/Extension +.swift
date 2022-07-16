//
//  Extension +.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/15.
//

import UIKit

protocol InformationProtocol {
    associatedtype Item: Displayable
    func setUpInformations(_ product: Item)
    func loadImage(_ urlString: String)
}

//let linkURL: String
//let thumbnailURL: String

protocol Displayable {

}

extension UICollectionReusableView {
    static var reuseIdentifier: String { String(describing: Self.self)}
}
