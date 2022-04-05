//
//  AuthenticationTextField.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

class SignInTextField: UITextField {
    
    private let type: TextFieldType?
    
    private lazy var eyePasswordToggleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.addTarget(self, action: #selector(didTapEyePasswordToggleButton), for: .touchUpInside)
        button.tintColor = .lightGray
        button.tag = 1
        button.isHidden = true
        
        return button
    }()
    
    init(type: TextFieldType) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        changeClearButtonColor()
    }
    
    public func setupEyeToggleButtonVisible(isHidden: Bool) {
        eyePasswordToggleButton.isHidden = isHidden
    }
    
}

private extension SignInTextField {
    
    func setupView() {
        setupByType()
        setupDefaultProperties()

        autocorrectionType = .no
        autocapitalizationType = .none
    }
    
    func setupByType() {
        guard let type = type else {
            return
        }
        
        switch type {
        case .login:
            layer.maskedCorners = [.layerMaxXMinYCorner,
                                   .layerMinXMinYCorner]
            attributedPlaceholder = NSAttributedString(
                string: "Email или телефон",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            clearButtonMode = .whileEditing
        case .password:
            layer.maskedCorners = [.layerMaxXMaxYCorner,
                                   .layerMinXMaxYCorner]
            attributedPlaceholder = NSAttributedString(
                string: "Пароль",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            isSecureTextEntry = true
            rightView = eyePasswordToggleButton
            rightViewMode = .always
        }
        
    }
    
    private func changeClearButtonColor() {
        for button in subviews.compactMap({ $0 as? UIButton }) {
            if let image = button.imageView?.image, button.tag == 0 {
                button.setImage(image.withTintColor(.lightGray), for: .normal)
            }
        }
    }
    
    @objc func didTapEyePasswordToggleButton() {
        isSecureTextEntry.toggle()
        eyePasswordToggleButton.isSelected.toggle()
    }
    
}

extension SignInTextField {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: Constant.EdgeInset.signInTextField)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: Constant.EdgeInset.signInTextField)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: Constant.EdgeInset.signInTextField)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: bounds.width - 40, y: 0, width: 30 , height: bounds.height)
    }
    
}
