//
//  DTO.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import Foundation
class  DTO<T> { // Data Transfer Object
    
    var success :Bool?
    var model : T?
    var list = [T]()
    var message: String?
    var status :Bool?
    
    init(){}
    
    init(success:Bool, status:Bool, model:T, message:String){
        self.success = success
        self.status = status
        self.model = model
        self.message = message
        self.status = status
    }
    
    init(success:Bool, status:Bool, list:[T], message:String){
        self.success = success
        self.status = status
        self.list = list
        self.message = message
        
    }
    
    init(success: Bool, status:Bool) {
        self.success = success
        self.status = status
    }
    
    init(success: Bool, message:String) {
        self.success = success
        self.message = message
        if !success{
            status = false
        }
    }
    
}

