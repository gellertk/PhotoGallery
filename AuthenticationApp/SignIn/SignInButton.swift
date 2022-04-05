//
//  AuthenticationSignInButton.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

class SignInButton: UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.white.withAlphaComponent(0.3) : UIColor.white
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? UIColor.white : UIColor.white.withAlphaComponent(0.3)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SignInButton {
    
    func setupView() {
        isEnabled = false
        setTitle("Войти", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = Constant.Numeric.defaultCornerRadius
    }
    
}
