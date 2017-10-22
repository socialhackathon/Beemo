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
            UserDefaults.standard.set(token, forKey: "token")
            completion()
            //let parameter = ["key": token]

        }, error: error)
      
    }
    
    
}
