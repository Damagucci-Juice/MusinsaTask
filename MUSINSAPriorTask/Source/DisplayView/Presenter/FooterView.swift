//
//  FooterView.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import UIKit
import Kingfisher
import SnapKit

class FooterView: UICollectionReusableView {
    
    let footerButton: UIButton = {
        let button = PaddingButton()
        button.setTitle("###푸터###", for: .normal)
        button.setImage(UIImage(named: "arrow.clockwise"), for: .normal)
        button.setTitleColor(.systemGray3, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.layer.cornerRadius = button.intrinsicContentSize.height / 2
        button.layer.borderColor = .init(gray: .pi, alpha: .pi)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(footerButton)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        footerButton.setTitle(nil, for: .normal)
        footerButton.setImage(nil, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        footerButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}



extension FooterView: Informable {
    func setUpInformations(_ product: Footer) {
        switch product.type {
        case "REFRESH":
            footerButton.setTitle("새로운 추천", for: .normal)
            guard let url = product.iconURL else { return }
            loadImage(url)
            
            if #available(iOS 14.0, *) {
                footerButton.addAction(UIAction(handler: { uiaction in
                    print("새로운 추천 버튼 눌림")
                }), for: .touchUpInside)
            }
            else if #available(iOS 13.6, *) {
                footerButton.addTarget(self, action: #selector(reloadNewRecommand(_:)), for: .touchUpInside)
            }
            
        case "MORE":
            footerButton.setTitle("더보기", for: .normal)
            if #available(iOS 14.0, *) {
                footerButton.addAction(UIAction(handler: { uiaction in
                    print("더보기 버튼 눌림")
                }), for: .touchUpInside)
            }
            else if #available(iOS 13.6, *) {
                footerButton.addTarget(self, action: #selector(reloadMoreProduct(_:)), for: .touchUpInside)
            }
        default:
            break
        }
    }
    
    @objc func reloadNewRecommand(_ sender: UIButton) {
        print("objc 새로운 추천 버튼 눌림")
    }
    
    @objc func reloadMoreProduct(_ sender: UIButton) {
        print("objc 더보기 버튼 눌림")
    }
    
    func loadImage(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        footerButton.imageView?.kf.setImage(with: url)
        footerButton.setImage(UIImage(named: "arrow.clockwise"), for: .normal)
    }
    
    typealias Item = Footer
}
