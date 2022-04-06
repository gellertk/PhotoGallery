//
//  AuthenticationView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

protocol InitialViewDelegate: AnyObject {
    func didTapToSignInVCButton()
    func didTapToRegistrationVCButton()
}

class InitialView: UIView {
    
    public weak var delegate: InitialViewDelegate?

    //TODO: Make it universal
    private let toSignInVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти в аккаунт", for: .normal)
        button.backgroundColor = Constant.Color.primary
        button.setTitleColor(Constant.Color.secondary, for: .normal)
        button.setTitleColor(Constant.Color.disabledSecondary, for: .highlighted)
        button.addTarget(self, action: #selector(didTapToSignInVCButton), for: .touchUpInside)

        return button
    }()
    
    private let toRegistrationVCButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = Constant.Color.primary
        button.setTitleColor(Constant.Color.secondary, for: .normal)
        button.setTitleColor(Constant.Color.disabledSecondary, for: .highlighted)
        button.addTarget(self, action: #selector(didTapToRegistrationVCButton), for: .touchUpInside)
        
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

private extension InitialView {
    
    func setupView() {
        addSubviews([toSignInVCButton,
                     toRegistrationVCButton])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            toSignInVCButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            toSignInVCButton.topAnchor.constraint(equalTo: topAnchor,
                                                  constant: UIScreen.main.bounds.height * 0.7),
            toSignInVCButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: Constant.Numeric.defaultBorderConstraint),
            toSignInVCButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -Constant.Numeric.defaultBorderConstraint),

            toRegistrationVCButton.heightAnchor.constraint(equalToConstant: Constant.Numeric.defaultUIElementHeight),
            toRegistrationVCButton.topAnchor.constraint(equalTo: toSignInVCButton.bottomAnchor,
                                                        constant: Constant.Numeric.defaultBorderConstraint / 2),
            toRegistrationVCButton.leadingAnchor.constraint(equalTo: toSignInVCButton.leadingAnchor),
            toRegistrationVCButton.trailingAnchor.constraint(equalTo: toSignInVCButton.trailingAnchor),
        
        ])
        
    }
    
    @objc func didTapToSignInVCButton() {
        delegate?.didTapToSignInVCButton()
    }
    
    @objc func didTapToRegistrationVCButton() {
        delegate?.didTapToRegistrationVCButton()
    }
    
}
