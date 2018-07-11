//
//  UserActivity.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import Foundation
import SwiftyJSON


class Location: Model {
    var lat = ""
    var lon = ""
    
    required init(json: JSON) {
        super.init(json: json)
        
        lat = json["lat"].stringValue
        lon = json["lon"].stringValue
    }
}

class Attender: Model {
    
    var userKey = ""
    var attendedAt: String?
    var name: String?
    var city: String?
    var avatar:String{
        return "http://stg.api.tipi.me/cdn/user/\(userKey)/savatar.jpg"
    }
    
    required init(json: JSON) {
        super.init(json: json)
        
        userKey = json["user_key"].stringValue
        attendedAt = json["attended_at"].stringValue
        name = json["name"].stringValue
        city = json["city"].stringValue
    }
}

class UserActivity: Model{
    
    var docKey: String = ""
    var userKey:String = ""
    var title: String?
    var description:String?
    var image: String?
    var at: String?
    var address:String?
    var hasAttended = false
    var hasAttender: Bool{
        return attendees.count > 0
    }
    var attendees = [Attender]()
    var location: Location?
    
    var userAvatar:String{
        return "http://stg.api.tipi.me/cdn/user/\(userKey)/savatar.jpg"
    }
    
    required init(json: JSON) {
        super.init(json: json)
        
        docKey  = json["doc_key"].stringValue
        userKey = json["user_key"].stringValue
        title = json["title"].stringValue
        description = json["description"].stringValue
        image = json["image"].stringValue
        
        at = json["at"].stringValue
        address = json["address"].stringValue
        hasAttended = json["has_attended"].boolValue
        attendees = json["attendees"].arrayValue.map{ Attender(json: $0)}
        location = Location(json: json["location"])
    }
}
