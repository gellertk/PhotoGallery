//
//  AuthenticationTextField.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

// TODO: Make it universal
class AuthenticationTextField: UITextField {
    
    private let type: AuthenticationTextFieldType?
    
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
    
    init(type: AuthenticationTextFieldType) {
        self.type = type
        super.init(frame: .zero)
        setupView()
        tag = AuthenticationTextField.getUniqueTag()
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

private extension AuthenticationTextField {
    
    func setupView() {
        setupByType()
        layer.cornerRadius = Constant.Numeric.defaultCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        textColor = Constant.Color.secondary
        backgroundColor = .darkGray
        autocorrectionType = .no
        autocapitalizationType = .none
    }
    
    func setupByType() {
        guard let type = type else {
            return
        }
        
        switch type {
        case .signInLogin:
            clearButtonMode = .whileEditing
        case .signInPassword:
            isSecureTextEntry = true
            rightView = eyePasswordToggleButton
            rightViewMode = .always
        case .signUpLogin:
            break
        case .signUpPassword:
            break
        }
        
        attributedPlaceholder = NSAttributedString(
            string: type.title,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
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

extension AuthenticationTextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: Constant.EdgeInset.signInTextField)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: Constant.EdgeInset.signInTextField)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: Constant.EdgeInset.signInTextField)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {

        return CGRect(x: bounds.width - 40, y: 0, width: 30 , height: bounds.height)
    }
    
}
