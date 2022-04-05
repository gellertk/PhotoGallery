//
//  AuthenticationViewController.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

class AuthenticationViewController: UIViewController {

    private lazy var authenticationView: AuthenticationView = {
        let view = AuthenticationView()
        view.authenticationViewController = self

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    public func openSignInViewController() {
        let signInViewController = UINavigationController(rootViewController: SignInViewController()) 
        signInViewController.modalPresentationStyle = .overFullScreen
        present(signInViewController, animated: true)
    }

}

private extension AuthenticationViewController {
    
    func setupView() {
        [authenticationView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        view.makeSubviewConstraintsEqualToEdges(view: authenticationView)
    }
    
}
