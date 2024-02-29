//
//  SceneDelegate.swift
//  Millionaire
//
//  Created by Kate Kashko on 25.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = MainViewController()
//        window?.makeKeyAndVisible()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = AmountViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}

