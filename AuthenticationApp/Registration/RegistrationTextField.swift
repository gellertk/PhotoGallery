////
////  RegistrationTextField.swift
////  AuthenticationApp
////
////  Created by Кирилл  Геллерт on 05.04.2022.
////
//
//import UIKit
//
//class RegistrationTextField: UITextField {
//
//    init(placeholder: String) {
//        super.init(frame: .zero)
//        self.attributedPlaceholder = NSAttributedString(
//            string: placeholder,
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
//        )
//        setupView()
//        tag = RegistrationTextField.getUniqueTag()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//private extension RegistrationTextField {
//
//    func setupView() {
//        setupDefaultProperties()
//    }
//
//}
//
//extension RegistrationTextField {
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//
//        return bounds.inset(by: Constant.EdgeInset.signInTextField)
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//
//        return bounds.inset(by: Constant.EdgeInset.signInTextField)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//
//        return bounds.inset(by: Constant.EdgeInset.signInTextField)
//    }
//
//    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
//
//        return CGRect(x: bounds.width - 40, y: 0, width: 30 , height: bounds.height)
//    }
//
//}
//
//
