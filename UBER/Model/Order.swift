//
//  Order.swift
//  UBER
//
//  Created by ZYFAR on 22.10.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Order {
    var provider: Int?
    var customer: Int!
    var status: String!
    var fromPoint: String!
    var toPoint: String!
    var time: String!
    
    init(from: String, to: String) {
        fromPoint = from
        toPoint = to
        let date = NSDate()
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm:ss"
        customer = 1
        status = "0"
        time = formater.string(from: date as Date)
    }
    
    init(json: JSON) {
        provider = json["provider_id"].intValue
        customer = json["customer_id"].intValue
        fromPoint = json["from_point"].stringValue
        toPoint = json["to_point"].stringValue
        time = json["time"].stringValue
        status = json["status"].stringValue
    }
    
    func toDict() -> [String: Any] {
        return ["from_point" : fromPoint,
                "to_point" : toPoint,
                "time" : time,
                "customer_id" : customer,
                "status": status
        ]
    }
}

class Orders: NSObject {
    override init() {}
    var array: Array = Array<Order>()
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Order(json:json)
            array.append(tempObject)
        }
    }
}
