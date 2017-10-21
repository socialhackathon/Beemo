//
//  ServerManager.swift
//  UBER
//
//  Created by ITLabAdmin on 10/21/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerManager: HTTPRequestManager  {
    
    var addUser: Login?
    class var shared: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }
    
    func addUser(login: Login, completion: @escaping () -> Void, error: @escaping (String) -> Void) {
        let param = login.toDict()
            post(api: "profile",parameters: param, completion: { (json) in completion()
            }, error: error)
    }
    
    func login(login: String, password: String, completion: @escaping (Int)-> Void,error: @escaping (String)-> Void) {
        var token = ""
        self.post(api: "login", parameters: ["username": login, "password": password], completion: { (json) in
            token = json["token"].stringValue
            let parameter = ["key": token]
            self.post(api: "user_id", parameters: parameter, completion: { json in
                let user_id = json["user_id"].intValue
                UserDefaults.standard.set(user_id, forKey: "user_id")
                completion(user_id)
            }, error: error)
        }, error: error)
        if token != "" {
            UserDefaults.standard.set(token, forKey: "token")
        }
    }
    
    
}
