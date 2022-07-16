//
//  PaddingLabel.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/15.
//

import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 3.0, left: 8.0, bottom: 3.0, right: 8.0)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
}
