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
        //        if Database.shared.activeUser != nil {
        //            self.window?.rootViewController = MainNavigationController(rootViewController: InitialViewController())
        //            //self.window?.rootViewController?.present(AuthenticationViewController(type: .signIn), animated: true, completion: nil)
        //            //window?.rootViewController?.modalPresentationStyle = .fullScreen
        //        } else {
        //            self.window?.rootViewController = MainNavigationController(rootViewController: InitialViewController())
        //        }
        self.window?.rootViewController = RootViewController()
        self.window?.makeKeyAndVisible()
    }
    
}

