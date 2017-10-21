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
    func saveUserInformation(userDictionary: [String: String]){
        uDefaults.set(userDictionary, forKey: "user_information")
    }
    
    func getUserInformation() -> [String: String]? {
        guard let user_information = uDefaults.object(forKey: "user_information") else {
            return nil
        }
        return user_information as! [String : String]
    }
    func getUser() -> [String: String]? {
        guard let username = uDefaults.string(forKey: "username"), let password = uDefaults.string(forKey: "password") else {
            return nil
        }
        return ["username": username, "password": password]
    }
}

