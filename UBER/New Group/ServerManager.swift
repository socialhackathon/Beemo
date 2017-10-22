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
            post(api: "profile/",parameters: param, completion: { (json) in completion()
            }, error: error)
    }
    
    func addOrder(order: Order, completion: @escaping () -> Void, error: @escaping (String) -> Void) {
        let param = order.toDict()
        post(api: "order/", parameters: param, completion: { (json) in
            print(param)
        }, error: error)
    }
    
    func login(login: String, password: String, completion: @escaping ()-> Void,error: @escaping (String)-> Void) {
        
        self.post(api: "login/", parameters: ["username": login, "password": password], completion: { (json) in
            let token = json["token"].stringValue
            let parameter = ["key": token]
            self.post(api: "user_id/", parameters: parameter, completion: { (json) in
                let user_id = json["user_id"].intValue
                DataManager.shared.saveUserId(id: user_id)
            }, error: error)
            
            
            UserDefaults.standard.set(token, forKey: "token")
            completion()

        }, error: error)
    }
 
    func getUser(_ completion: @escaping (Login)-> Void, error: @escaping (String)-> Void) {
        let id = DataManager.shared.getUserId()
        self.get(api: "profile/\(id))", completion: { (json) in
            completion(Login(json: json))
        }, error: error)
    }

}
