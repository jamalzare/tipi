//
//  UserActivity.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserActivity: Model{
   
    var docKey: String = ""
    var userKey:String = ""
    var title: String?
    var description:String?
    var location: String?
    var image: String?
    var at: String?
    var address:String?
    var hasAttend = false
    var attends = [String]()
    
    required init(json: JSON) {
        super.init(json: json)
        
        docKey  = json["docKey"].stringValue
        userKey = json["user_key"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        image = json["image"].stringValue
        
        at = json["at"].stringValue
        address = json["address"].stringValue
        hasAttend = json["has_attended"].boolValue
    }
}
