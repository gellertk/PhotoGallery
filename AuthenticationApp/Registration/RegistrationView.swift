//
//  RegistrationView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

class RegistrationView: UIView {
    
    public weak var registrationViewController: RegistrationViewController? {
        didSet {
            for subview in subviews.compactMap({ $0 as? UITextField }) {
                subview.delegate = registrationViewController
            }
        }
    }
    
    private let firstNameTextField = RegistrationTextField(placeholder: "Имя")
    private let lastNameTextField = RegistrationTextField(placeholder: "Фамилия")
    private let emailTextField = RegistrationTextField(placeholder: "Email")
    private let passwordNameTextField = RegistrationTextField(placeholder: "Пароль")
    
    private lazy var registrationFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                       lastNameTextField,
                                                       emailTextField,
                                                       passwordNameTextField],
                                    axis: .vertical, spacing: 10, distribution: .fillProportionally)
        
        return stackView
    }()
    
    private let signUpButton: SignInButton = {
        let button = SignInButton()
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension RegistrationView {
    
    func setupView() {
        [registrationFieldsStackView,
         signUpButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
    
            registrationFieldsStackView.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            registrationFieldsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            registrationFieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Numeric.defaultBorderConstraint),
            registrationFieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Numeric.defaultBorderConstraint),

            signUpButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            signUpButton.topAnchor.constraint(equalTo: registrationFieldsStackView.bottomAnchor,
                                              constant: Constant.Numeric.defaultBorderConstraint / 2),
            signUpButton.leadingAnchor.constraint(equalTo: registrationFieldsStackView.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: registrationFieldsStackView.trailingAnchor),
            
        ])
        
    }
    
    @objc func didTapSignUpButton() {
        //authenticationViewController?.openSignInViewController()
    }
    
}
