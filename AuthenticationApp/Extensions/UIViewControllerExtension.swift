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
    
    func addChoosePhotoBarButton() {
        let choosePhotoBarButton = UIBarButtonItem(title: "Выбрать",
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(didTapChoosePhotoBarButton))
        choosePhotoBarButton.customView?.layer.cornerRadius =  choosePhotoBarButton.width / 2
        choosePhotoBarButton.customView?.backgroundColor = .darkGray
        choosePhotoBarButton.tintColor = Constant.Color.secondary
        navigationItem.leftBarButtonItem = choosePhotoBarButton
    }
    
    @objc func didTapCloseBarButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapExitBarButton() {
        Database.shared.removeActiveUser()
       //dismiss(animated: true)
    }
    
    @objc func didTapChoosePhotoBarButton() {
        //authenticationViewController?.openSignInViewController()
    }
    
    func presentFullScreenViewController(viewController: UIViewController,
                                         animate style: UIModalTransitionStyle = .coverVertical) {
        let vc = MainNavigationController(rootViewController: viewController)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = style
        present(vc, animated: true)
    }
    
}

