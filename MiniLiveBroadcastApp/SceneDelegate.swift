//
//  SceneDelegate.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/4.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //get windowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // get rootViewController
        let vc = ViewController()
        
        window.rootViewController = vc
        
        self.window = window
        // Reference: https://ioscoachfrank.com/remove-main-storyboard.html
        window.makeKeyAndVisible()
    }
}

