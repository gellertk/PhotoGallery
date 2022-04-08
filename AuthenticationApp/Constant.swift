//
//  Constant.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

struct Constant {
    
    struct String {
      
    }
    
    struct Color {
        static let primary: UIColor = .black
        static let secondary: UIColor = .white
        static let disabledSecondary: UIColor = secondary.withAlphaComponent(Numeric.defaultDisabledAlpha)
        static let disabledPrimary: UIColor = primary.withAlphaComponent(Numeric.defaultDisabledAlpha)
    }
    
    struct Numeric {
        static let defaultDisabledAlpha: CGFloat = 0.3
        static let defaultBorderConstraint: CGFloat = 20
        static let defaultCornerRadius: CGFloat = 10
        static let defaultUIElementHeight: CGFloat = 44
        static let defaultTopButtonConstraint: CGFloat = 40
    }
    
    struct EdgeInset {
        static let signInTextField = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30)
    }
    
    struct Collection {
        static let modelProperties = ["login",
                                       "password"]
    }
    
}
