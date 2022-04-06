//
//  AuthenticationView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

protocol SignInViewDelegate: AnyObject {
    func didTapSignInButton()
}

class SignInView: UIView {
        
    public weak var delegate: SignInViewDelegate?
    
    private let errorView = ErrorView()
    
    private let loginTextField = AuthenticationTextField(type: .signInLogin)
    private let passwordTextField = AuthenticationTextField(type: .signInPassword)
    
    private lazy var signInTextFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField,
                                                       passwordTextField],
                                    axis: .vertical,
                                    spacing: 10,
                                    distribution: .fillEqually)
        
        return stackView
    }()
    
    private let signInButton: AuthenticationButton = {
        let button = AuthenticationButton(title: "Войти")
        button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(_ textFieldTag: Int) {
        passwordTextField.setupEyeToggleButtonVisible(isHidden: textFieldTag == 1)
    }
    
    func showError(text: String) {
        errorView.setupErrorLabel(text: text)
    }
    
}

private extension SignInView {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        addSubviews([errorView,
                     signInTextFieldsStackView,
                     signInButton])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            signInTextFieldsStackView.topAnchor.constraint(equalTo: topAnchor,
                                                constant: UIScreen.main.bounds.height * 0.3),
            signInTextFieldsStackView.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            signInTextFieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: Constant.Numeric.defaultBorderConstraint),
            signInTextFieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constant.Numeric.defaultBorderConstraint),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                              constant: Constant.Numeric.defaultTopButtonConstraint),
            signInButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            signInButton.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            
            errorView.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight * 2),
            errorView.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: loginTextField.topAnchor,
                                              constant: -Constant.Numeric.defaultBorderConstraint / 2)
            
        ])
        
        for subview in signInTextFieldsStackView.subviews {
            subview.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight).isActive = true
        }
        
    }
    
    func setupDelegates() {
        for textField in signInTextFieldsStackView.allTextFields {
            textField.delegate = self
        }
    }
    
    @objc func didTapSignInButton() {
        delegate?.didTapSignInButton()
    }
    
}

extension SignInView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeNextResponder(textField: textField)
        
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        if updatedString.isEmpty {
            signInButton.isEnabled = false
        } else {
            signInButton.isEnabled = setupButtonAvailablity(button: signInButton,
                                                            editedTextFieldTag: textField.tag)
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        signInButton.isEnabled = false
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTextField.setupEyeToggleButtonVisible(isHidden: textField.tag == 1)
    }
    
}
