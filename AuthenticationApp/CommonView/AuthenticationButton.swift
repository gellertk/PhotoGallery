//
//  AuthenticationSignInButton.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

class AuthenticationButton: UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Constant.Color.disabledSecondary : Constant.Color.secondary
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? Constant.Color.secondary :  Constant.Color.disabledSecondary
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension AuthenticationButton {
    
    func setupView() {
        isEnabled = false
        setTitleColor(Constant.Color.primary, for: .normal)
        layer.cornerRadius = Constant.Numeric.defaultCornerRadius
    }
    
}
