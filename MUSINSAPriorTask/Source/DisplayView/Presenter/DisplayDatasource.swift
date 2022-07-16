//
//  DisplayDatasource.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/16.
//

import UIKit
import SwiftUI

class DisplayDatasource: NSObject, UICollectionViewDataSource {
    
    /// model[0] === Banner
    /// model[1] === GridGood
    /// model[2] === ScrollGood
    /// model[3] === Style
    private var model: [Datum]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = model else { return 0 }
        switch section {
        case 0: //Banner
            guard let count = model[section].contents.banners?.count else { return 0 }
            return count
        case 1: //Grid
            guard let count = model[section].contents.goods?.count else { return 0 }
            return count
        case 2: //Scroll
            guard let count = model[section].contents.goods?.count else { return 0 }
            return count
        default: //Style
            guard let count = model[section].contents.styles?.count else { return 0 }
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView
                    .dequeueReusableCell(
                        withReuseIdentifier: BannerCell.reuseIdentifier,
                        for: indexPath) as? BannerCell,
                  let banner = model?[indexPath.section].contents.banners?[indexPath.row]
            else { return UICollectionViewCell() }
            
            cell.setUpInformations(banner)
            return cell
        case 1...2:
            guard let cell = collectionView
                    .dequeueReusableCell(
                        withReuseIdentifier: DisplayGoodCell.reuseIdentifier,
                        for: indexPath) as? DisplayGoodCell,
                  let goods = model?[indexPath.section].contents.goods?[indexPath.row]
            else { return UICollectionViewCell() }
            
            cell.setUpInformations(goods)
            return cell
        default:
            guard let cell = collectionView
                    .dequeueReusableCell(
                        withReuseIdentifier: StyleCell.reuseIdentifier,
                        for: indexPath) as? StyleCell,
                  let style = model?[indexPath.section].contents.styles?[indexPath.row]
            else { return UICollectionViewCell() }
            
            cell.setUpInformations(style)
            return cell
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let count = model?.count else { return 0 }
        return count
    }
    
    
    func updateModel(_ model: [Datum]) {
        self.model = model
    }
    
    private func isValid(indexPath: IndexPath) -> Bool {
        guard let model = model else { return false }
        return 0 <= indexPath.section && indexPath.section < model.count
    }
}
