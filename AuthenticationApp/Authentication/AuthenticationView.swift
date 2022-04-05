//
//  AuthenticationView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

class AuthenticationView: UIView {
    
    public weak var authenticationViewController: AuthenticationViewController?
    
    private let toSignInVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти в другой аккаунт", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.3), for: .highlighted)
        button.addTarget(self, action: #selector(didTapToSignInVCButton), for: .touchUpInside)

        return button
    }()
    
    private let toRegistrationVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.3), for: .highlighted)
        
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

private extension AuthenticationView {
    
    func setupView() {
        [toSignInVCButton,
         toRegistrationVCButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            toSignInVCButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            toSignInVCButton.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.8),
            toSignInVCButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.Numeric.defaultBorderConstraint),
            toSignInVCButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.Numeric.defaultBorderConstraint),

            toRegistrationVCButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            toRegistrationVCButton.topAnchor.constraint(equalTo: toSignInVCButton.bottomAnchor,
                                                        constant: Constant.Numeric.defaultBorderConstraint / 2),
            toRegistrationVCButton.leadingAnchor.constraint(equalTo: toSignInVCButton.leadingAnchor),
            toRegistrationVCButton.trailingAnchor.constraint(equalTo: toSignInVCButton.trailingAnchor),
        
        ])
        
    }
    
    @objc func didTapToSignInVCButton() {
        authenticationViewController?.openSignInViewController()
    }
    
}
