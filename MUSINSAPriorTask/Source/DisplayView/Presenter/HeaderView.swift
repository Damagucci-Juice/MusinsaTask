//
//  HeaderView.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import UIKit
import Kingfisher
import SnapKit


class HeaderView: UICollectionReusableView {
    
    var model: Header?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "placeholderImage")
        return imageView
    }()

    
    private let totalButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .light)
        button.setTitleColor(.systemGray, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [titleLabel, titleImageView, totalButton].forEach {
            self.addSubview($0)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        totalButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(5)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        totalButton.isHidden = true
        titleImageView.image = nil
        titleLabel.text = nil
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        totalButton.isHidden = (model?.linkURL == nil) ? true : false
        
        if model?.iconURL != nil {
            titleImageView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(titleLabel.snp.leading).offset(-5)
                $0.width.height.equalTo(20)
            }
        }
    }
}


extension HeaderView: Informable {
    func setUpInformations(_ product: Header) {

        if let iconUrlString = product.iconURL,
           let linkUrlString = product.linkURL,
           let linkUrl = URL(string: linkUrlString) {
            
            loadImage(iconUrlString)
            totalButton.isHidden = false
            
            if #available(iOS 14.0, *) {
                totalButton.addAction(UIAction(handler: { uiaction in
                    UIApplication.shared.open(linkUrl)
                }), for: .touchUpInside)
            }
            else if #available(iOS 13.6, *) {
                totalButton.addTarget(self, action: #selector(openLinkURL(_:)), for: .touchUpInside)
            }

        }
        self.model = product
        titleLabel.text = product.title
        layoutIfNeeded()
    }
    
    @available(iOS 13.6, *)
    @objc func openLinkURL(_ sender: UIButton) {
        guard let urlString = model?.linkURL,
              let url = URL(string: urlString)
        else { return }
        
        UIApplication.shared.open(url)
    }
    
    func loadImage(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        titleImageView.kf.setImage(with: url)
    }
    
    typealias Item = Header
}
