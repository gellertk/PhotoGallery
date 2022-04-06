//
//  UserDefaultsManager.swift
//  AuthenticationApp
//
//  Created by Кирилл  Геллерт on 06.04.2022.
//

import Foundation

class Database {
    
    static let shared = Database()
    
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue
    let activeUserKey = SettingKeys.activeUser.rawValue
    
    var users: [User] {
        
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                if let data = try? PropertyListDecoder().decode([User].self, from: data) {
                    return data
                }
            }
            return [User]()
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
        
    }
    
    var activeUser: User? {
        
        get {
            if let data = defaults.value(forKey: activeUserKey) as? Data {
                if let data = try? PropertyListDecoder().decode(User.self, from: data) {
                    return data
                }
            }
            return nil
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: activeUserKey)
            }
        }
        
    }
    
    func saveUser(login: String,
                  password: String) {
        
        let user = User(login: login, password: password, avatar: Data())
        users.insert(user, at: 0)
    }
    
    func removeActiveUser() {
        defaults.removeObject(forKey: activeUserKey)
    }
    
    func saveActiveUser(user: User) {
        activeUser = user
    }
    
    func findUser(login: String) -> User? {
        
        for user in users {
            if user.login == login {
                return user
            }
        }
        
        return nil
    }
    
}
