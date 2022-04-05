//
//  TextFieldExtension.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

extension UITextField {
    
    func setupDefaultProperties() {
        layer.cornerRadius = Constant.Numeric.defaultCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        textColor = .white
        backgroundColor = .darkGray
    }

}
