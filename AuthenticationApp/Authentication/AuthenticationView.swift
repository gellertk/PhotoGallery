//
//  RegistrationView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

protocol AuthenticationViewDelegate: AnyObject {
    func didTapSignUpButton()
    func didTapSignInButton()
}

class AuthenticationView: UIView {
    
    private var type: AuthenticationInterfaceType?
    
    public weak var delegate: AuthenticationViewDelegate?
    
    private let errorView = ErrorView()
    
    private lazy var signUpLoginTextField = AuthenticationTextField(type: .signUpLogin)
    private lazy var signUpPasswordTextField = AuthenticationTextField(type: .signUpPassword)
    
    private lazy var signInLoginTextField = AuthenticationTextField(type: .signInLogin)
    private lazy var signInPasswordTextField = AuthenticationTextField(type: .signInPassword)
    
    public lazy var textFieldsStackView: UIStackView = {

        var arrangedSubviews: [UITextField] = []
        
        switch type {
        case .signIn:
            arrangedSubviews = [signInLoginTextField, signInPasswordTextField]
        case .signUp:
            arrangedSubviews = [signUpLoginTextField, signUpPasswordTextField]
        case .none:
            break
        }
    
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews,
                                    axis: .vertical,
                                    spacing: Constant.Numeric.defaultBorderConstraint / 2,
                                    distribution: .fillEqually)
        
        return stackView
    }()
    
    private lazy var authenticationButton: AuthenticationButton = {
        let button = AuthenticationButton(title: type?.buttonTitle ?? "")
        button.addTarget(self, action: #selector(didTapAuthenticationButton), for: .touchUpInside)
        
        return button
    }()
    
    init(type: AuthenticationInterfaceType?) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showError(text: String) {
        errorView.setupErrorLabel(text: text)
    }
    
    func setupAuthenticationButtonAvailability(currentString: String, textFieldTag: Int) {
        if currentString.isEmpty {
            authenticationButton.isEnabled = false
        } else {
            authenticationButton.isEnabled = textFieldsStackView.setupButtonAvailability(button: authenticationButton,
                                                                                      editedTextFieldTag: textFieldTag)
        }
    }
    
}

private extension AuthenticationView {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        addSubviews([textFieldsStackView,
                     authenticationButton,
                     errorView])
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            textFieldsStackView.topAnchor.constraint(equalTo: topAnchor,
                                                           constant: UIScreen.main.bounds.height * 0.3),
            textFieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                               constant: Constant.Numeric.defaultBorderConstraint),
            textFieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                constant: -Constant.Numeric.defaultBorderConstraint),
            
            authenticationButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            authenticationButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor,
                                              constant: Constant.Numeric.defaultTopButtonConstraint),
            authenticationButton.leadingAnchor.constraint(equalTo: textFieldsStackView.leadingAnchor),
            authenticationButton.trailingAnchor.constraint(equalTo: textFieldsStackView.trailingAnchor),
            
            errorView.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight * 2),
            errorView.leadingAnchor.constraint(equalTo: textFieldsStackView.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: textFieldsStackView.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor,
                                              constant: -Constant.Numeric.defaultBorderConstraint / 2)
        ])
        
        for subview in textFieldsStackView.subviews {
            subview.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight).isActive = true
        }
        
    }
    
    @objc func didTapAuthenticationButton() {
        if type == .signUp {
            delegate?.didTapSignUpButton()
        } else if type == .signIn {
            delegate?.didTapSignInButton()
        }
    }
    
}
