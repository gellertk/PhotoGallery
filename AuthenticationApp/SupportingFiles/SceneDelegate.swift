//
//  SceneDelegate.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        self.window = UIWindow(windowScene: windowScene)
        //let navigationViewController = AuthenticationViewController()
        self.window?.rootViewController = AuthenticationNavigationController(rootViewController: AuthenticationViewController())
        self.window?.makeKeyAndVisible()
    }
    
}

