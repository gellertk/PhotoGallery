//
//  RegistrationView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

protocol SignUpViewDelegate: AnyObject {
    func didTapSignUpButton()
}

class SignUpView: UIView {
    
    public weak var delegate: SignUpViewDelegate?
    
    private let errorView = ErrorView()
    
    private let loginTextField = AuthenticationTextField(type: .signUpLogin)
    private let passwordNameTextField = AuthenticationTextField(type: .signUpPassword)
    
    public lazy var signUpTextFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField,
                                                       passwordNameTextField],
                                    axis: .vertical,
                                    spacing: 10,
                                    distribution: .fillEqually)
        
        return stackView
    }()
    
    private let signUpButton: AuthenticationButton = {
        let button = AuthenticationButton(title: "Зарегистрироваться")
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        
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
    
    func showError(text: String) {
        errorView.setupErrorLabel(text: text)
    }
    
}

private extension SignUpView {
    
    func setupView() {
        backgroundColor = Constant.Color.primary
        addSubviews([signUpTextFieldsStackView,
                     signUpButton,
                     errorView])
        setupConstraints()
    }
    
    func setupDelegates() {
        for textField in signUpTextFieldsStackView.allTextFields {
            textField.delegate = self
        }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            signUpTextFieldsStackView.topAnchor.constraint(equalTo: topAnchor,
                                                           constant: UIScreen.main.bounds.height * 0.3),
            signUpTextFieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                               constant: Constant.Numeric.defaultBorderConstraint),
            signUpTextFieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                constant: -Constant.Numeric.defaultBorderConstraint),
            
            signUpButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            signUpButton.topAnchor.constraint(equalTo: signUpTextFieldsStackView.bottomAnchor,
                                              constant: Constant.Numeric.defaultTopButtonConstraint),
            signUpButton.leadingAnchor.constraint(equalTo: signUpTextFieldsStackView.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: signUpTextFieldsStackView.trailingAnchor),
            
            errorView.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight * 2),
            errorView.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: loginTextField.topAnchor,
                                              constant: -Constant.Numeric.defaultBorderConstraint / 2)
        ])
        
        for subview in signUpTextFieldsStackView.subviews {
            subview.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight).isActive = true
        }
        
    }
    
    @objc func didTapSignUpButton() {
        delegate?.didTapSignUpButton()
    }
    
}

extension SignUpView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        signUpTextFieldsStackView.makeNextResponder(textField: textField)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        if updatedString.isEmpty {
            signUpButton.isEnabled = false
        } else {
            signUpButton.isEnabled = signUpTextFieldsStackView.setupButtonAvailablity(button: signUpButton,
                                                                                      editedTextFieldTag: textField.tag)
        }
        
        return true
    }
    
}
