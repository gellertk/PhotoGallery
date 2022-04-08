//
//  UIImageExtension.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 08.04.2022.
//

import UIKit

extension UIImage {
    
    convenience init?(url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        self.init(data: data)
    }
    
}
