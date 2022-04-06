//
//  Enumeration.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import Foundation

enum AuthenticationTextFieldType {
    case signInLogin
    case signInPassword
    case signUpLogin
    case signUpPassword
    
    var title: String {
        switch self {
        case .signInLogin:
            return "Логин"
        case .signInPassword:
            return "Пароль"
        case .signUpLogin:
            return "Логин"
        case .signUpPassword:
            return "Пароль"
        }
    }
}

enum AuthenticationInterfaceType {
    case signIn
    case signUp
}

enum SettingKeys: String {
    case users
    case activeUser
}
