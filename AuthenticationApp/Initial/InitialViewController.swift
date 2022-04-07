//
//  AuthenticationViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

class InitialViewController: UIViewController {
    
    override func loadView() {
        let view = InitialView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeServiceCall()
    }
    
    private func makeServiceCall() {
        if Database.shared.activeUser != nil {
            SceneDelegate.shared.rootViewController.switchToMainScreen()
        }
    }
    
}

extension InitialViewController: InitialViewDelegate {
    
    func didTapToSignInVCButton() {
        presentFullScreenViewController(viewController: AuthenticationViewController(type: .signIn))
    }
    
    func didTapToRegistrationVCButton() {
        presentFullScreenViewController(viewController: AuthenticationViewController(type: .signUp))
    }
    
}
