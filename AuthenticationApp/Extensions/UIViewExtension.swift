//
//  UIViewExtension.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import UIKit

extension UIView {
    
    var allTextFields: [UITextField] {
        return subviews.compactMap { $0 as? UITextField }.sorted { $0.tag < $1.tag }
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func makeNextResponder(textField: UITextField) {
        
        textField.resignFirstResponder()
        
        if let nextTextField = subviews.firstIndex(where: { $0.tag == textField.tag + 1 }),
           let nextTextField = subviews[nextTextField] as? UITextField {
            
            nextTextField.becomeFirstResponder()
        }
    }
    
    func getTextFieldsPropertiesAndValues(properties: [String]) -> [String: String] {
        
        var propertiesAndValues: [String: String] = [:]
        
        for (index, property) in properties.enumerated() {
            propertiesAndValues[property] = allTextFields[index].text
        }
        
        return propertiesAndValues
    }
    
    //MARK: If all textfields has text, make button enabled
    func setupButtonAvailability(button: UIButton,
                                editedTextFieldTag: Int) -> Bool {
        
        for textField in allTextFields {
            if textField.tag != editedTextFieldTag, textField.text?.count == 0 {
                return false
            }
        }
        
        return true
    }
    
}

