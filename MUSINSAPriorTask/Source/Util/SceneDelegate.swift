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
//        let mainVC = DisplayViewController(repository: DisplayRepositoryImplement())
        let mainVC = DisplayViewController()
//        let mainVC = UIViewController()
//        mainVC.view.backgroundColor = .systemBlue
        let navigationController = UINavigationController(rootViewController: mainVC)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
    }
}

