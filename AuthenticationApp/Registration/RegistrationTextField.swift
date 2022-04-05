//
//  RegistrationTextField.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

class RegistrationTextField: UITextField {
    
    private static var tagFactory = 0

    init(placeholder: String) {
        super.init(frame: .zero)
        setupView()
        tag = RegistrationTextField.getUniqueTag()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension RegistrationTextField {
    
    func setupView() {
        setupDefaultProperties()
    }
    
    static func getUniqueTag() -> Int {
        tagFactory += 1
        return tagFactory
    }
    
}
