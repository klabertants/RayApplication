//
//  AuthViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import Foundation
import UIKit
import VK_ios_sdk

final class AuthViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let buttonSize = CGSize(width: 300, height: 20)
        authButton.frame = CGRect(x: view.bounds.midX - buttonSize.halfWidth,
                                  y: view.bounds.midY - buttonSize.halfHeight,
                                  size: buttonSize)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(authButton)
        view.backgroundColor = RayColor.blueRayColor
        authButton.setTitle("Авторизоваться", for: .normal)
        authButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
    }
    
    private let authButton = UIButton()
    @objc private func authorize() {
        VKSdk.authorize(permissions)
    }
}

extension AuthViewController: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        fatalError("Капча хуяпча")
    }
}
