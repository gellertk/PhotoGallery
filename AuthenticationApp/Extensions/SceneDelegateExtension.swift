//
//  AppDelegateExtension.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 07.04.2022.
//

import UIKit

extension SceneDelegate {
    static var shared: SceneDelegate {
        return UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
    }
    
    var rootViewController: RootViewController {
        let windowsScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowsScene?.delegate as? SceneDelegate
        
        return sceneDelegate?.window?.rootViewController as! RootViewController
    }
}
