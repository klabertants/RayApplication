//
//  NavigationBarController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class NavigationBarController: UIViewController {
    
    init(titlePresenter: Presenting,
         leftPresenter: Presenting? = nil,
         rightPresenter: Presenting? = nil) {
        self.titlePresenter = titlePresenter
        self.leftPresenter = leftPresenter
        self.rightPresenter = rightPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NavigationBarView()
    }
    
    override func viewDidLoad() {
        let subviews = [leftPresenter?.view, titlePresenter.view, rightPresenter?.view].compactMap { $0 }
        subviews.forEach { view.addSubview($0) }
        view.backgroundColor = RayColor.tabBarColor
    }
    
    override func viewDidLayoutSubviews() {
        let bounds = view.bounds
        let height = bounds.height
        
        var minX = 0 as CGFloat
        if let leftView = leftPresenter?.view {
            leftView.sizeToFit()
            var leftFrame = leftView.frame
            leftFrame.origin.x = 0
            leftFrame.origin.y = bounds.midY - leftFrame.height / 2
            leftView.frame = leftFrame
            minX = leftFrame.maxX
        }
        
        var maxX = bounds.width
        if let rightView = rightPresenter?.view {
            rightView.sizeToFit()
            var rightFrame = rightView.frame
            rightFrame.origin.x = maxX - rightFrame.width
            rightFrame.origin.y = bounds.midY - rightFrame.height / 2
            rightView.frame = rightFrame
            maxX = rightFrame.minX
        }
        
        let titleWidth = maxX - minX
        titlePresenter.view.frame = CGRect(x: minX,
                                           y: bounds.midY - height / 2,
                                           width: titleWidth,
                                           height: height)
    }
    
    func fixSize(navigationBarHeight: CGFloat) {
        if #available(iOS 11.0, *) {
            return
        }
        
        view.bounds = CGRect(x: 0,
                             y: 0,
                             width: UIView.layoutFittingExpandedSize.width,
                             height: navigationBarHeight)
    }
    
    private let leftPresenter: Presenting?
    private let titlePresenter: Presenting
    private let rightPresenter: Presenting?
}

private final class NavigationBarView: UIView {
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return UIView.layoutFittingExpandedSize
    }
}

extension UIViewController {
    func inject(_ navigationBarController: NavigationBarController) {
        guard let navigationController = self.navigationController else { return }
        
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.backgroundColor = RayColor.tabBarColor
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItems = nil
        navigationItem.titleView = navigationBarController.view
        let height = navigationController.navigationBar.frame.size.height
        navigationBarController.fixSize(navigationBarHeight: height)
    }
}
