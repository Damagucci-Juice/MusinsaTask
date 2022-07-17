//
//  BannerCell.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import UIKit
import SnapKit
import Kingfisher

class BannerCell: UICollectionViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero,
                                                  size: CGSize(width: UIScreen.main.scale,
                                                               height: UIScreen.main.scale)))
        imageView.image = UIImage(named: "placeholderImage")
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let pageLabel: UILabel = {
        let label = PaddingLabel()
        label.text = "0 / 20"
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 13, weight: .thin)
        label.backgroundColor = .systemGray
        label.textColor = .systemGray6
        label.layer.cornerRadius = label.intrinsicContentSize.height / 2
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.numberOfLines = 2
        label.text = """
                    쿠어 21 S/S
                    신상품 한정 발매
                    """
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    let keywordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.text = "Showcase"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.text = "신상품 증정 이벤트"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        contentView.addSubview(cellImageView)

        [titleLabel, keywordLabel, descriptionLabel, pageLabel].forEach {
            cellImageView.addSubview($0)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        keywordLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        
        
        descriptionLabel.snp .makeConstraints {
            $0.leading.equalTo(keywordLabel)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(keywordLabel)
            $0.bottom.equalTo(descriptionLabel.snp.top)
            $0.width.lessThanOrEqualToSuperview().multipliedBy(0.6)
        }
        
        pageLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
        titleLabel.text = nil
        keywordLabel.text = nil
        descriptionLabel.text = nil
        pageLabel.text = nil
    }
}

extension BannerCell: Informable {
    func setUpInformations(_ product: Banner) {
        titleLabel.text = product.title
        keywordLabel.text = product.keyword
        descriptionLabel.text = product.bannerDescription
        loadImage(product.thumbnailURL)
    }
    
    func loadImage(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        cellImageView.kf.setImage(with: url)
    }
    
    func updatePageNumber(_ totalNumber: Int, _ currentPageNumber: Int) {
        pageLabel.text = "\(currentPageNumber) /\(totalNumber)"
    }
    
    typealias Item = Banner
}
