//
//  Login.swift
//  UBER
//
//  Created by ITLabAdmin on 10/21/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Login {
    var id : Int
    var phone_number: String
    var first_name: String
    var last_name: String
    var password: String
    var is_male: Bool = false
    init() {
        id = 0
        phone_number = ""
        first_name = ""
        last_name = ""
        password = ""
    }
    
    init(json: JSON) {
        id = json["id"].intValue
        phone_number = json["phone_number"].stringValue
        first_name = json["first_name"].stringValue
        last_name = json["last_name"].stringValue
        password = json["password"].stringValue
    }
    
    func toDict() -> [String: Any] {
        return ["phone_number": phone_number, "first_name": first_name, "last_name": last_name, "password": password, "is_male": is_male]
    }
}

class Logins: NSObject {
    override init() {}
    var array: Array = Array<Login>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Login(json:json)
            array.append(tempObject)
        }
    }
    
}

struct User {
    var userid: Int
    var username: String
    var password: String
    
    init(userid: Int, username: String, password: String) {
        self.userid = userid
        self.username = username
        self.password = password
    }
}
