//
//  UIViewControllerExtension.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

extension UIViewController {
    
    func addCloseBarButton() {
        let closeBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapCloseBarButton))
        closeBarButton.tintColor = .white
        navigationItem.leftBarButtonItem = closeBarButton
    }
    
    func addExitBarButton() {
        let exitBarButton = UIBarButtonItem(title: "Выйти",
                                            style: .done,
                                            target: self,
                                            action: #selector(didTapExitBarButton))
        exitBarButton.tintColor = .red
        navigationItem.rightBarButtonItem = exitBarButton
    }
    
    @objc func didTapCloseBarButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapExitBarButton() {
        Database.shared.removeActiveUser()
        SceneDelegate.shared.rootViewController.switchToLogout()
    }

    
    func presentFullScreenViewController(viewController: UIViewController,
                                         animate style: UIModalTransitionStyle = .coverVertical) {
        let vc = MainNavigationController(rootViewController: viewController)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = style
        present(vc, animated: true, completion: nil)
    }
    
}

