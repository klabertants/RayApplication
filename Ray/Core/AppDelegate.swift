//
//  AppDelegate.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit
import VK_ios_sdk

private let VK_APP_ID = "6747016"
let permissions = ["notify", "friends", "wall"]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var authVC: AuthViewController?
    private lazy var vkSDK: VKSdk = { return VKSdk.initialize(withAppId: VK_APP_ID)! }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let rootViewController = RootTabBarController(authRequest: requestAuthorization)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        vkSDK.register(self)
        
        UIApplication.shared.statusBarView?.backgroundColor = RayColor.tabBarColor
        
        VKSdk.wakeUpSession(permissions) { (state, _) in
            switch state {
            case .authorized:
                break
            default:
                self.requestAuthorization()
            }
        }
        
        return true
    }
    
    private func requestAuthorization() {
        authVC = AuthViewController()
        vkSDK.uiDelegate = authVC
        window?.rootViewController?.present(authVC!, animated: true, completion: nil)
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print("Open from another app")
        return true
    }
}

extension AppDelegate: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        authVC?.dismiss(animated: true, completion: nil)
        authVC = nil
    }
    
    func vkSdkUserAuthorizationFailed() {
        return
    }
}
