//
//  User.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import Foundation

struct User: Codable {
    let login: String
    let password: String
    let avatar: Data
}
