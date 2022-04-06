//
//  ViewController.swift
//  signInApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    private var type: AuthenticationInterfaceType?
    
    private lazy var signInView: AuthenticationView  = {
        let view = AuthenticationView(type: type)
        view.delegate = self
        
        return view
    }()
    
    init(type: AuthenticationInterfaceType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ScrollViewContainer(with: signInView)
        addCloseBarButton()
    }
    
}

extension AuthenticationViewController: AuthenticationViewDelegate {
    
    func didTapSignInButton() {
        let propertiesAndValues =
            signInView.getTextFieldsPropertiesAndValues(properties: Constant.Collection.signInProperties)
        
        guard let user = Database.shared.findUser(login: propertiesAndValues["login"] ?? "") else {
            signInView.showError(text: "Неверный логин или пароль")
            return
        }
        
        if user.password == propertiesAndValues["password"] ?? "" {
            presentFullScreenViewController(viewController: MainTabBarController(),
                                            animate: .flipHorizontal)
            
            Database.shared.saveActiveUser(user: user)
            
        } else {
            signInView.showError(text: "Неверный логин или пароль")
        }
    }
    
}
