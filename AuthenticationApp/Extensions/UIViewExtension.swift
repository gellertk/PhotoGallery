//
//  UIViewExtension.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

extension UIView {
    
    func makeNextResponder(textField: UITextField) {
        
        textField.resignFirstResponder()
        
        if let nextTextField = subviews.firstIndex(where: { $0.tag == textField.tag + 1 }),
            let nextTextField = subviews[nextTextField] as? UITextField {
            
            nextTextField.becomeFirstResponder()
        }
        
    }
    
    func makeSubviewConstraintsEqualToEdges(view: UIView) {
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}

