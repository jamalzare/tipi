//
//  LoginService.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import Foundation
class LoginService: Service{
    
    static var sharedInstance = LoginService()
    private override init(){}
    
    func login(callback : @escaping ()->Void){
        
        var params = ["version": "2"]
        params["auth"] = "6db16284-755d-4c33-a55b-0940a8495fad"
        params["email"] = "jamalzare514@gmail.com"
        params["device"] = "ios"
        
       
        RequestManger.handleRequest(api: "/v1/users/login", parameters: params, methodType: "post", arrayParam: []) { (status, json, message, code) in
            
            callback()
            
        }
    }
    
    func getList(callback:@escaping (DTO<UserActivity>)-> Void){
        
        let api = "/v1/user_activities"//?location[lat]=-33.868583&location[lon]=151.225348"
        
//        var par = ["location[lat]": "-33.868583"]
//        par["location[lon]"] = "151.225348"
//        par = [:]
        //let array = []
        RequestManger.handleRequest(api: api, parameters: [:], methodType: "get", arrayParam: []) { (status, json, message, code) in
            
            
            if let jsonData = json?["data"]["list"] {
            
            var list = [UserActivity]()
            for  (_, js) in jsonData{
                list.append(UserActivity(json: js))
            }
            let dto = DTO(success: true, status: true, list: list, message: "")
            
                callback(dto)
                print(json ?? "jghj")
            }
        }
    }
    
}
