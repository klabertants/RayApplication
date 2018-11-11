//
//  EmptyPresenter.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class EmptyPresenter : Presenting {
    
    init(of size: CGSize) {
       self.size = size
    }
    
    var view: UIView {
        return emptyView
    }
    
    private lazy var emptyView : UIView = {
        let tempView = UIView(frame: CGRect(x: 0, y: 0,
                                            width: size.width,
                                            height: size.height))
        return tempView
    }()
    private let size : CGSize
}
