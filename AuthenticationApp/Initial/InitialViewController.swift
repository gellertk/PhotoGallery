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

}

extension InitialViewController: InitialViewDelegate {
    
    func didTapToSignInVCButton() {
        presentFullScreenViewController(viewController: AuthenticationViewController())
    }
    
    func didTapToRegistrationVCButton() {
        presentFullScreenViewController(viewController: AuthenticationViewController())
    }
    
}
