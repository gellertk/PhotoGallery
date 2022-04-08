//
//  User.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import Foundation

struct User: Codable {
    
    var login: String
    let password: String
    var avatarURL: URL?
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
        self.avatarURL = nil
    }
    
}
