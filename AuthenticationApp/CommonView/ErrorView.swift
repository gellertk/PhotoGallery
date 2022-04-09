//
//  ErrorView.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import UIKit

class ErrorView: UIView {
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red.withAlphaComponent(0.8)
        label.text = "Неверный логин или пароль"
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red.withAlphaComponent(0.3)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupErrorLabel(text: String) {
        errorLabel.text = text
        isHidden = false
    }
    
}

private extension ErrorView {
    
    func setupView() {
        isHidden = true
        layer.cornerRadius = Constant.Numeric.defaultCornerRadius

        addSubviews([errorLabel])
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
    }
    
}
