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
    private(set) var model: [Datum]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = model else { return 0 }

        guard let count = model[section].contents[section]?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView
                    .dequeueReusableCell(
                        withReuseIdentifier: BannerCell.reuseIdentifier,
                        for: indexPath) as? BannerCell,
                  let bannerSection = model?[indexPath.section].contents.banners
            else { return UICollectionViewCell() }
            let bannerItem = bannerSection[indexPath.row]
            
            cell.setUpInformations(bannerItem)
            cell.updatePageNumber(
                bannerSection.count,
                indexPath.row + 1
            )
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView,
                  let header = model?[indexPath.section].header
            else { assert(false, "여긴 호출 안될겁니다.. 아마?") }
            
            headerView.setUpInformations(header)
            
            return headerView
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterView.reuseIdentifier, for: indexPath) as? FooterView,
                  let footer = model?[indexPath.section].footer
            else { assert(false, "여긴 호출 안될겁니다.. 아마?") }
            //TODO: - 
            footerView.setUpInformations(footer)
            return footerView
        default:
            assert(false, "여긴 호출 안될겁니다.. 아마?")
        }
        
    }
}
