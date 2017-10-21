//
//  Login.swift
//  UBER
//
//  Created by ITLabAdmin on 10/21/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Login{
    var phone_number: String
    var first_name: String
    var last_name: String
    var password: String
    var is_male: Bool?
    init() {
        phone_number = ""
        first_name = ""
        last_name = ""
        password = ""
    }
    
    init(json: JSON) {
        phone_number = json["phone_number"].stringValue
        first_name = json["first_number"].stringValue
        last_name = json["last_name"].stringValue
        password = json["password"].stringValue
    }
    func toDict() -> [String: Any] {
        return ["phone_number": phone_number, "first_name": first_name, "last_name": last_name, "password": password]
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
