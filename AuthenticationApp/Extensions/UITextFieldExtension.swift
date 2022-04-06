//
//  TextFieldExtension.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 05.04.2022.
//

import UIKit

extension UITextField {
    
    static var tagFactory = 0
    
    static func getUniqueTag() -> Int {
        tagFactory += 1
        return tagFactory
    }
    
}
