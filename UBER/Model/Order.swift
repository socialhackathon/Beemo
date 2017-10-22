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
    var fromPoint: String!
    var toPoint: String!
    var time: String!
    
    init() {
        fromPoint = ""
        toPoint = ""
        time = ""
    }
    init(json: JSON) {
        fromPoint = json["from_point"].stringValue
        toPoint = json["to_point"].stringValue
        time = json["time"].stringValue
    }
    
    func toDict() -> [String: Any] {
        return ["from_point" : fromPoint,
                "to_point" : toPoint,
                "time" : time]
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
