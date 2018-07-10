//
//  RequestManger.swift
//  tipi
//
//  Created by Jamal on 7/7/18.
//  Copyright © 2018 Jamal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestManger<T: Model>{
    
    static var serverRoot: String{
        get{
            return "http://stg.api.tipi.me"
        }
    }
    
    
    static func operationRequest(api:String, parameters:[String: Any], methodType:HTTPMethod = .get, arrayParam:[Any] = [], callBack:@escaping (DTO<T>)->Void){
        
        handleRequest(api: api, parameters: parameters, methodType: methodType, arrayParam: arrayParam){success, json, message, statusCode in
            
            if success{
                let statusCode = json?["statusCode"].intValue ?? 0
                let message = json?["message"].stringValue ?? ""
                callBack(DTO<T>(success: true, status: statusCode>0, message: message, statusCode: statusCode))
                
            }else{
                callBack(DTO<T>(success: false, message: message))
            }
            
        }
    }
    
    static func modelRequest(api:String, parameters:[String: Any?] = [:] , methodType:HTTPMethod = .post, callBack:@escaping (DTO<T>)->Void){
        
        handleRequest(api: api, parameters: parameters, methodType: methodType){success, json, message, serverStatusCode in
            
            if success{
                
                if (json?["statusCode"].exists())!, (json?["message"].exists())! {
                    
                    let statusCode = json?["statusCode"].intValue ?? 0
                    let message = json?["message"].stringValue ?? ""
                    callBack(DTO<T>(success: true, status: false, message:message, statusCode:statusCode))
                }else{
                    let model = T.init(json: json!["data"])
                    callBack(DTO<T>(success: true, status: true, model:model, message:""))
                }
                
            }else{
                let dro = DTO<T>(success: false, message: message)
                callBack(dro)
            }
            
        }
        
    }
    
    static func listRequest(api:String, parameters:[String: Any] = [:], methodType:HTTPMethod = .post, arrayParam:[Any] = [], callBack:@escaping (DTO<T>)->Void){
        
        handleRequest(api: api, parameters: parameters, methodType: methodType, arrayParam: arrayParam){success, json, message, statusCode in
            
            if success{
                
                if (json?["statusCode"].exists())!, (json?["message"].exists())! {
                    
                    let statusCode = json?["statusCode"].intValue ?? 0
                    let message = json?["message"].stringValue ?? ""
                    
                    callBack(DTO<T>(success: true, status: false, message:message, statusCode:statusCode))
                    
                }else{
                    
                    let data = json!["data"]["list"]
                    var list = [T]()
                    for  (_, js) in data{
                        list.append(T(json: js))
                    }
                    
                    callBack(DTO<T>(success: true, status:true, list: list, message: ""))
                }
                
            }else{
                callBack(DTO<T>(success: false, message: message))
                
            }
            
        }
        
    }
    
    
    private static func setRequestByApi(_ api:String)-> URLRequest
    {
        let encodedApi = api.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let requestUrl = URL(string: serverRoot + encodedApi!)
        return URLRequest(url: requestUrl!)
    }
    
    private static func getParametersData(parameters:[String: Any], arrayParam:[Any] = [])-> Data?{
        
        let objectForJson:Any = arrayParam.count>0 ? arrayParam: parameters
        let data = try! JSONSerialization.data(withJSONObject: objectForJson, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if (arrayParam.count) > 0 || (parameters.keys.count) > 0
        {
            print(json ?? "")
            return json!.data(using: String.Encoding.utf8.rawValue)
        }
        return nil
    }
    
    private static func getCookie(response: DataResponse<Any>){
        if let
            header = response.response?.allHeaderFields as? [String: String], let URL = response.request?.url
        {
            if let cookies = HTTPCookie.cookies(withResponseHeaderFields: header, for: URL).first{
                
                HTTPCookieStorage.shared.setCookie(cookies)
            }
        }
    }
    
    static func handleRequest(api:String, parameters:[String: Any], methodType: HTTPMethod = .post, arrayParam:[Any] = [], callBack:@escaping (Bool,JSON?,String, Int)->Void){
        
        var request = setRequestByApi(api)
        request.httpMethod = methodType.rawValue
        
        if parameters.keys.count>0{
            request.httpBody = getParametersData(parameters: parameters)
        }
        sendRequest(request, params: parameters, callBack: callBack)
    }
    
    private static func sendRequest(_ request: URLRequest, params :[String: Any],  callBack:@escaping (Bool,JSON?,String, Int)->Void)
    {
        let params = params.keys.count>0 ? params : nil
        let url = request.url!
        let method = request.httpMethod == "POST" ? HTTPMethod.post : HTTPMethod.get
        
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            
            switch response.result {
                
            case .success( _):
                getCookie(response: response)
                handleSuccessResponse(response, callBack: callBack)
                
            case .failure(let error):
                handleFailureResponse(response, error:error, callBack: callBack)
                
            }
        }
    }
    
    private static func handleSuccessResponse(_ response: DataResponse<Any>, callBack:@escaping (Bool,JSON?,String, Int)->Void){
        
        let statusCode = (response.response?.statusCode) ?? 1
        let json = JSON(response.result.value!)
        callBack(true, json, "", statusCode)
    }
    
    private static func handleFailureResponse(_ response: DataResponse<Any>, error:Error, callBack:@escaping (Bool,JSON?,String, Int)->Void){
        
        let statusCode = (response.response?.statusCode) ?? 0
        let message = handleError(error: error, statusCode: statusCode)
        callBack(false, JSON.null, message, statusCode)
    }
    
    private static func handleError(error: Error, statusCode:Int)->String{
        
        var message = ""
        
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                message = "Invalid URL: \(url) - \(error.localizedDescription)"
            case .parameterEncodingFailed(let reason):
                message = "Parameter encoding failed: \(error.localizedDescription)"
                message += " Failure Reason: \(reason)"
            case .multipartEncodingFailed(let reason):
                message = "Multipart encoding failed: \(error.localizedDescription)"
                message += " Failure Reason: \(reason)"
            case .responseValidationFailed(let reason):
                message = "Response validation failed: \(error.localizedDescription)"
                message += " Failure Reason: \(reason)"
            case .responseSerializationFailed(let reason):
                message = "Response serialization failed: \(error.localizedDescription)"
                message += " Failure Reason: \(reason)"
            }
            let unerlineError = error.underlyingError
            message = "Underlying error: \(String(describing: unerlineError))"
            
        } else if let error = error as? URLError {
            
            message = "URLError occurred: \(error)"
        } else {
            
            message = "Unknown error: \(error)"
        }
        
        return "Error Code is: \(statusCode) -> Error Message:" + message
    }
    
    
    
}
