//
//  Constant.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit
import Foundation

struct Constant {
    
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
        static let ciFilters: KeyValuePairs = [
            "CIBumpDistortion": UIImage(systemName: "circle.lefthalf.filled"),
            "CIGaussianBlur": UIImage(systemName: "circle.dashed.inset.filled"),
            "CIPixellate": UIImage(systemName: "circle.dashed"),
            "CISepiaTone": UIImage(systemName: "circle.and.line.horizontal"),
            "CITwirlDistortion": UIImage(systemName: "circle.and.line.horizontal"),
            "CIUnsharpMask": UIImage(systemName: "wand.and.rays"),
            "CIVignette": UIImage(systemName: "dial.max.fill")
        ]
        
        static let tabBarTitlesAndImages: KeyValuePairs = [
            "Галерея фото": UIImage(systemName: "photo.on.rectangle.angled") ?? UIImage(),
            "Список пользователей": UIImage(systemName: "person.fill") ?? UIImage(),
        ]
    }
    
}
