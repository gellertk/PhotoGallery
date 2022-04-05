//
//  AuthenticationView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

class SignInView: UIView {
    
    public weak var signInViewControllerDelegate: SignInViewController? {
        didSet {
            loginTextField.delegate = signInViewControllerDelegate
            passwordTextField.delegate = signInViewControllerDelegate
        }
    }
    
    private lazy var loginTextField: SignInTextField = {
        let textField = SignInTextField(type: .login)
        textField.tag = 1
        
        return textField
    }()
    
    private lazy var passwordTextField: SignInTextField = {
        let textField = SignInTextField(type: .password)
        textField.tag = 2
        
        return textField
    }()
    
    private let signInButton: SignInButton = {
        let button = SignInButton()
        button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        
        return button
    }()
    
//    private let separatorView: UIView = {
//        let view = UIView(frame: CGRect.init(x: 0.0, y: 0.0, width: 0.0, height: 1))
//        view.backgroundColor = .lightGray
//
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
        default:
            passwordTextField.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(_ textFieldTag: Int) {
        passwordTextField.setupEyeToggleButtonVisible(isHidden: textFieldTag == 1)
    }
    
    public func setupSignInButton(editedTextFieldIsEmpty: Bool, editedTextFieldTag: Int) {
        if editedTextFieldIsEmpty {
            signInButton.isEnabled = false
            return
        }
        
        [passwordTextField, loginTextField].forEach {
            if $0.tag != editedTextFieldTag, $0.text?.count != 0 {
                signInButton.isEnabled = true
            }
        }
   }
    
}

private extension SignInView {
    
    func setupView() {
        backgroundColor = .darkGray
        [loginTextField,
         passwordTextField,
         signInButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            loginTextField.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.4),
            loginTextField.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementsHeight),
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constant.Numeric.defaultBorderConstraint),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constant.Numeric.defaultBorderConstraint),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementsHeight),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            signInButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementsHeight),
            signInButton.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            
            //            separatorView.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            //            separatorView.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            //            separatorView.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor)
            
        ])
        
    }
    
    @objc func didTapSignInButton() {
        
    }
    
}
