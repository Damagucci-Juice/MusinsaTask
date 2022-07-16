//
//  DisplayCell.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/15.
//

import UIKit
import Kingfisher
import SnapKit

final class DisplayCell: UICollectionViewCell {
    
    var item: Good?
    // MARK: - UI
    let cellImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero,
                                                  size: CGSize(width: UIScreen.main.scale,
                                                               height: UIScreen.main.scale)))
        imageView.image = UIImage(named: "placeholderImage")
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        return imageView
    }()
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    let saleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemRed
        label.text = "99"
        label.textAlignment = .right
        return label
    }()
    
    let couponLabel: UILabel = {
        let label = PaddingLabel()
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.text = "쿠폰"
        label.clipsToBounds = true
        label.layer.cornerRadius = label.intrinsicContentSize.height / 2
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 0.8
        return stackView
    }()
    
    let priceInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [cellImageView, brandLabel, priceInformationStackView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(cellImageView.snp.width)
        }
        
        brandLabel.snp.makeConstraints {
            $0.top.equalTo(cellImageView.snp.bottom).offset(1)
            $0.leading.equalToSuperview()
        }
        priceInformationStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(2)
            $0.top.equalTo(brandLabel.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        cellImageView.image = nil
        brandLabel.text = nil
        priceLabel.text = nil
        saleLabel.text = nil
        couponLabel.isHidden = true
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        guard let item = item else { return }
        var informStackviewSubviews = [priceLabel, saleLabel]
        if item.hasCoupon {
            informStackviewSubviews.append(couponLabel)
        }
        informStackviewSubviews.forEach {
            priceInformationStackView.addArrangedSubview($0)
        }
    }
    
}

extension DisplayCell: InformationProtocol {

    typealias Item = Good
    
    func setUpInformations(_ product: Item) {
        self.item = product
        brandLabel.text = product.brandName.rawValue
        priceLabel.text = "\(product.price)"
        saleLabel.text = "\(product.saleRate)%"
        loadImage(product.thumbnailURL)
        self.layoutIfNeeded()
    }
    
    func loadImage(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        cellImageView.kf.setImage(with: url)
    }
}
