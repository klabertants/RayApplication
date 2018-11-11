//
//  RayViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import Foundation
import UIKit

class RayViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        subscribeForDBUpdates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subscribeForDBUpdates() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateFromDatabase),
                                               name: Notification.yapStorageModified,
                                               object: nil)
    }
    
    private func unsubscribeFromDBUpdates() {
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.yapStorageModified,
                                                  object: nil)
    }
    
    @objc func updateFromDatabase() {
        fatalError("Should be overriden!!")
    }
    
    deinit {
        unsubscribeFromDBUpdates()
    }
}
