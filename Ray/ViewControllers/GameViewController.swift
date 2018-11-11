//
//  GameViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 10/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

final class GameViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let imageSize = CGSize(width: 30, height: 30)
        let image = UIImage(named: "tab-game")?.resize(targetSize: imageSize).withRenderingMode(.alwaysOriginal)
        tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RayColor.gameColor
        playVideo()
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "vid", ofType:"m4v") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - tabBarHeight)
        self.view.layer.addSublayer(playerLayer)
        player.play()
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        present(playerController, animated: true) {
//            player.play()
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
