//
//  StyleCell.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/17.
//

import UIKit
import SnapKit
import Kingfisher

class StyleCell: UICollectionViewCell {

    let cellImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero,
                                                  size: CGSize(width: UIScreen.main.scale,
                                                               height: UIScreen.main.scale)))
        imageView.image = UIImage(named: "placeholderImage")
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            contentView.addSubview(cellImageView)
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

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
}


extension StyleCell: Informable {
    func setUpInformations(_ product: Style) {
        loadImage(product.thumbnailURL)
    }
    
    func loadImage(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        cellImageView.kf.setImage(with: url)
    }
    
    typealias Item = Style
}
