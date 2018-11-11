//
//  RootTabBarController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class RootTabBarController: UITabBarController {
    
    init(authRequest: @escaping () -> Void) {
        self.authRequest = authRequest
        super.init(nibName: nil, bundle: nil)
        let wrappedMapVC = UINavigationController(rootViewController: MapViewController())
        
        let profileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
        let imageSize = CGSize(width: 30, height: 30)
        let image = UIImage(named: "tab-profile")?.resize(targetSize: imageSize).withRenderingMode(.alwaysOriginal)
        profileVC.tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: image)
        let wrappedProfileVC = UINavigationController(rootViewController: profileVC)
        
        let tasksVC = TasksViewController()
        let tasksImage = UIImage(named: "tab-tasks")?.resize(targetSize: imageSize).withRenderingMode(.alwaysOriginal)
        tasksVC.tabBarItem = UITabBarItem(title: nil, image: tasksImage, selectedImage: tasksImage)
        let wrappedTasksVC = UINavigationController(rootViewController: tasksVC)
        
        let petsVC = PetsViewController()
        let petsImage = UIImage(named: "tab-pets")?.resize(targetSize: imageSize).withRenderingMode(.alwaysOriginal)
        petsVC.tabBarItem = UITabBarItem(title: nil, image: petsImage, selectedImage: petsImage)
        let wrappedPetsVC = UINavigationController(rootViewController: petsVC)
        
        viewControllers = [wrappedMapVC, wrappedTasksVC, wrappedPetsVC, GameViewController(), wrappedProfileVC]
        tabBar.barTintColor = RayColor.tabBarColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let authRequest: () -> Void
}
