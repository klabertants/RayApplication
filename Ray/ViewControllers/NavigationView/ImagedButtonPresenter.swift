//
//  ImagedButtonPresenter.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

protocol ImagedButtonPresenterDelegate: class {
    func handleTap(_ imagedButtonPresenter: ImagedButtonPresenter)
}

final class ImagedButtonPresenter : Presenting {
    
    init(with image: UIImage) {
        self.image = image
    }
    
    var view: UIView { return imagedView }
    weak var delegate: ImagedButtonPresenterDelegate? = nil
    private lazy var imagedView : ImagedButtonView = {
        let resultView = ImagedButtonView(image: image)
        resultView.tapHandler = { [unowned self] in
            self.delegate?.handleTap(self)
        }
        return resultView
    }()
    private let image : UIImage
}

private final class ImagedButtonView : UIView {
    typealias TapHandler = () -> Void
    
    private static func makeImagedButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        return button
    }
    
    init(image: UIImage) {
        self.image = image
        imagedButton = ImagedButtonView.makeImagedButton(image: image)
        super.init(frame: CGRect.zero)
        addSubview(imagedButton)
        imagedButton.addTarget(self,
                               action: #selector(buttonTapped),
                               for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        imagedButton.frame = CGRect(x: center.x - kPresenterSize.width / 2,
                                   y: center.y - kPresenterSize.height / 2,
                                   width: kPresenterSize.width,
                                   height: kPresenterSize.height)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let isZeroSize = size.equalTo(.zero)
        let width = kPresenterSize.width
        let height = isZeroSize ? kPresenterSize.height : size.height
        return CGSize(width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped() {
        tapHandler?()
    }
    
    var tapHandler: TapHandler? = nil
    private var image: UIImage? = nil
    
    private let imagedButton: UIButton
}

private let kPresenterSize = CGSize(width: 32, height: 32)
