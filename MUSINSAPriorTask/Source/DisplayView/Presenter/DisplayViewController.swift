//
//  ViewController.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/13.
//

import UIKit
import SnapKit

final class DisplayViewController: UIViewController {
    
    var repository: DisplayRepository = DisplayRepositoryImplement()
    var datasource: DisplayDatasource = DisplayDatasource()
    let collectionView: UICollectionView = {
        let layout = DisplayLayoutFactory.create()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        attribute()
        layout()
        bind()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        collectionView.register(DisplayGoodCell.self,
                                forCellWithReuseIdentifier: DisplayGoodCell.reuseIdentifier)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseIdentifier)
        collectionView.register(StyleCell.self, forCellWithReuseIdentifier: StyleCell.reuseIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterView.reuseIdentifier)
        
        collectionView.dataSource = self.datasource
        collectionView.delegate = self
    }
    
    private func layout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind() {
        repository.onUpdate = { [unowned self] sections in
            self.datasource.updateModel(sections)
            self.collectionView.reloadData()
        }
    }
}

extension DisplayViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = datasource
                .model?[indexPath.section]
                .contents[indexPath.section]?[indexPath.row],
              let url = URL(string: selectedItem.linkURL)
        else { return }
        
        return UIApplication.shared.open(url)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 10
        return CGSize(width: width, height: height)
    }
    
}
