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
        print(login.toDict())
        return
            post(api: "login",parameters: param, completion: { (json) in completion()
            }, error: error)
    }
}
