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
    let avatarKey = SettingKeys.avatar.rawValue
    
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
    
    func saveAvatarURL(data: Data) {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documents.appendingPathComponent(UUID().uuidString)
        
        do {
            try data.write(to: url)
            if let index = users.firstIndex(where: {$0.login == activeUser?.login}) {
                users[index].avatarURL = url
            }
        } catch {
            print("Unable to Write Data to Disk (\(error))")
        }
    }
    
    func saveUser(login: String,
                  password: String) {
        
        let user = User(login: login, password: password)
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
