//
//  NavigationTitlePresenter.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class NavigationTitlePresenter: Presenting {
    var view: UIView { return titleView }
    
    func set(title: String) {
        titleView.set(title: title)
    }
    
    private let titleView = NavigationTitleView()
}

private final class NavigationTitleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    override func layoutSubviews() {
        let contentHeight = kLabelHeight
        let titleY = (bounds.height - contentHeight) / 2
        let labelSize = CGSize(width: bounds.width, height: kLabelHeight)
        titleLabel.frame = CGRect(x: 0, y: titleY, width: labelSize.width, height: labelSize.height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return titleLabel.sizeThatFits(size)
    }
    
    private func setupSubviews() {
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    private let titleLabel = UILabel()
}

private let kLabelHeight = 19 as CGFloat
