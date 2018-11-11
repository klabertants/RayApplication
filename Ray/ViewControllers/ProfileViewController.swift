//
//  ProfileViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit
import Kingfisher
import VK_ios_sdk
import LDProgressView

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        inject(navigationBar)
    }
    
    private func setupUI() {
        avatarView.layer.cornerRadius = avatarView.frame.halfHeight
        avatarView.clipsToBounds = true
        ldProgress.borderRadius = 5
        ldProgress.type = LDProgressStripes
        ldProgress.progress = 0.798
        ldProgress.color = RayColor.blueRayColor
        
        guard let user = VKSdk.accessToken()?.localUser else { return }
        if let photoLink = user.photo_200 {
            avatarView.kf.setImage(with: URL(string: photoLink))
        } else {
            avatarView.image = UIImage(named: "picture-profile")
        }
        vkLabel.text = user.id.stringValue
        nameLabel.text = user.first_name + " " + user.last_name
        phoneLabel.text = "+79998769221"
        emailLabel.text = "emil@iksanov.ru"
    }
    
    @IBOutlet weak var vkLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ldProgress: LDProgressView!
    
    private lazy var navigationBar: NavigationBarController = {
        let titlePresenter = NavigationTitlePresenter()
        titlePresenter.set(title: "Профиль")
        return NavigationBarController(titlePresenter: titlePresenter,
                                       leftPresenter: nil,
                                       rightPresenter: nil)
    }()
    
    @IBAction func openStats(_ sender: UIButton) {
        let statsVC = UIStoryboard(name: "Stats", bundle: nil).instantiateViewController(withIdentifier: "StatsViewController")
        navigationController?.pushViewController(statsVC, animated: true)
    }
    
    @IBAction func openShop(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "https://vk.com/market-36918666")!)
    }
    
    @IBAction func openDonate(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: "https://rayfund.ru/get_involved/donate/")!)
    }
    
    //    @objc private func logoutHandler() {
//        NetworkFacade.initiateUser()
//        VKSdk.forceLogout()
//        guard let rootTabBar = tabBarController as? RootTabBarController else { return }
//        rootTabBar.authRequest()
//    }
}
