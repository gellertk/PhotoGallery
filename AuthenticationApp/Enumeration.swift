//
//  Enumeration.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 04.04.2022.
//

import Foundation
import CoreImage
import UIKit

enum AuthenticationTextFieldType {
    case signInLogin
    case signInPassword
    case signUpLogin
    case signUpPassword
    
    var textFieldTitle: String {
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
    
    var buttonTitle: String {
        switch self {
        case .signIn:
            return "Войти"
        case .signUp:
            return "Зарегистрироваться"
        }
    }
}

enum SettingKeys: String {
    case users
    case activeUser
    case avatar
}

enum AlbumCollectionSectionType: Int {
    
    case all
    case smartAlbums
    case userCollections
    
    var description: String {
        switch self {
        case .all:
            return "Все фото"
        case .smartAlbums:
            return "Умный альбом"
        case .userCollections:
            return "Пользовательская коллекция"
        }
    }
    
}
