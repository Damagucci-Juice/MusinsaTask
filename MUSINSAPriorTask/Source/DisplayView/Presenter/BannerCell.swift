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

        [titleLabel, keywordLabel, descriptionLabel].forEach {
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
        
        keywordLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
        }
        
        
        descriptionLabel.snp .makeConstraints { make in
            make.leading.equalTo(keywordLabel)
            make.bottom.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(keywordLabel)
            make.bottom.equalTo(descriptionLabel.snp.top)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.6)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
        titleLabel.text = nil
        keywordLabel.text = nil
        descriptionLabel.text = nil
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
    
    typealias Item = Banner
}
