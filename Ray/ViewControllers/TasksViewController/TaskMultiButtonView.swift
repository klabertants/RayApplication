//
//  TaskMultiButtonView.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 10/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class TaskMultiButtonView: UIView {
    
    private func setupMessageView() {
        messageView.backgroundColor = RayColor.multiButtonOrange
        let messageImage = UIImage(named: "")
    }
    
    private let progressView = UIView()
    private let callView = UIView()
    private let messageView = UIView()
    
    private enum ProgressViewState {
        case start
        case inProgress
        case finish
    }
    
    
}

