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
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DisplayCell.self, forCellWithReuseIdentifier: DisplayCell.reuseIdentifier)
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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func layout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func bind() {
        repository.onUpdate = { [unowned self] in
            self.collectionView.reloadData()
        }
    }
}

extension DisplayViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = (repository as? DisplayRepositoryImplement)?.girdSection?.contents.goods?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DisplayCell.reuseIdentifier,
            for: indexPath) as? DisplayCell,
              // TODO:  - 디미터 법칙 위반
              let item = (repository as? DisplayRepositoryImplement)?
                .girdSection?
                .contents
                .goods?[indexPath.row]
        else { return UICollectionViewCell() }
        
        cell.setUpInformations(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: Int = Int((self.collectionView.frame.width - 6) / 3)
        let height: Int = 180
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let urlString = (repository as? DisplayRepositoryImplement)?
                .girdSection?
                .contents
                .goods?[indexPath.row]
                .linkURL,
              let url = URL(string: urlString)
        else { return }
        
        UIApplication.shared.open(url)
    }
}
