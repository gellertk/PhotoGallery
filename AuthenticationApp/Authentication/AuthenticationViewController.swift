//
//  ViewController.swift
//  signInApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    private var type: AuthenticationInterfaceType?
    
    private lazy var authenticationView: AuthenticationView  = {
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
        view = ScrollViewContainer(with: authenticationView)
        addCloseBarButton()
    }
    
    override func viewDidLoad() {
        setupDelegates()
    }
    
}

private extension AuthenticationViewController {
    
    func setupDelegates() {
        for textField in authenticationView.textFieldsStackView.allTextFields {
            textField.delegate = self
        }
    }
    
}

extension AuthenticationViewController: AuthenticationViewDelegate {
    
    func didTapSignUpButton() {
        let database = Database.shared
        
        let propertiesAndValues =
        authenticationView.textFieldsStackView.getTextFieldsPropertiesAndValues(properties: Constant.Collection.modelProperties)
        
        let login = propertiesAndValues["login"] ?? ""
        
        if database.findUser(login: login) == nil {
            database.saveUser(login: login,
                              password: propertiesAndValues["password"] ?? "")
            
            dismiss(animated: true, completion: nil)
            SceneDelegate.shared.rootViewController.switchToMainScreen()
            
            guard let user = database.findUser(login: login) else {
                return
            }
            
            database.saveActiveUser(user: user)
        } else {
            authenticationView.showError(text: "Пользователь с таким логином уже существует")
        }
    }
    
    func didTapSignInButton() {
        let propertiesAndValues =
        authenticationView.textFieldsStackView.getTextFieldsPropertiesAndValues(properties: Constant.Collection.modelProperties)
        
        guard let user = Database.shared.findUser(login: propertiesAndValues["login"] ?? "") else {
            authenticationView.showError(text: "Неверный логин или пароль")
            return
        }
        
        if user.password == propertiesAndValues["password"] ?? "" {
            
            dismiss(animated: true, completion: nil)
            SceneDelegate.shared.rootViewController.switchToMainScreen()
            Database.shared.saveActiveUser(user: user)
            
        } else {
            authenticationView.showError(text: "Неверный логин или пароль")
        }
    }
    
}

extension AuthenticationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        authenticationView.textFieldsStackView.makeNextResponder(textField: textField)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        authenticationView.setupAuthenticationButtonAvailability(currentString: currentString,
                                                                 textFieldTag: textField.tag)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? AuthenticationTextField else {
            return
        }
        textField.setupEyeToggleButtonVisible(isHidden: textField.tag == 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        guard let textField = textField as? AuthenticationTextField else {
            return
        }
        textField.setupEyeToggleButtonVisible(isHidden: true)
    }
    
}
