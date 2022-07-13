//
//  SceneDelegate.swift
//  MUSINSAPriorTask
//
//  Created by YEONGJIN JANG on 2022/07/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let vc = DisplayViewController()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = vc
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

