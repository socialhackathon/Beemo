//
//  DataManager.swift
//  UBER
//
//  Created by ITLabAdmin on 10/21/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager {
    
    class var shared: DataManager {
        struct Static {
            static let instance = DataManager()
        }
        return Static.instance
    }
    var uDefaults = UserDefaults.standard
    func saveUser(username: String, password: String) {
        uDefaults.set(username, forKey: "username")
        uDefaults.set(password, forKey: "password")
    }
    
    func getUser() -> [String: String]? {
        guard let username = uDefaults.string(forKey: "username"),
            let password = uDefaults.string(forKey: "password") else {
            return nil
        }
        return ["username": username, "password": password]
    }
    
    func getUserId() -> Int {
        return UserDefaults.standard.integer(forKey: "user_id")
    }
    
    func saveUserId(id: Int) {
        UserDefaults.standard.set(id, forKey: "user_id")
    }
    
}

