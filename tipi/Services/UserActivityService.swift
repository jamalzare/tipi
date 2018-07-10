//
//  UserActivityService.swift
//  tipi
//
//  Created by Jamal on 7/10/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import Foundation

import Foundation
class UserActivityService: Service{
    
    static var sharedInstance = UserActivityService()
    private override init(){}
    
    func getList(callback:@escaping (DTO<UserActivity>)-> Void){
        
        let api = "/v1/user_activities?location[lat]=-33.868583&location[lon]=151.225348"
        RequestManger<UserActivity>.listRequest(api: api,  methodType: .get){ dto in
            callback(dto)
        }
    }
    
}
