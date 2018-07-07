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
    
    
    private static func setRequestByApi(_ api:String)-> URLRequest
    {
        let encodedApi = api.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let requestUrl = URL(string: serverRoot + encodedApi!)
        print(requestUrl!)
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
            
//            print(cookies)
            }
        }
    }
    
    static func handleRequest(api:String, parameters:[String: Any], methodType:String, arrayParam:[Any] = [], callBack:@escaping (Bool,JSON?,String, Int)->Void){
        
        var request = setRequestByApi(api)
        request.httpMethod = methodType

        if parameters.keys.count>0{
            request.httpBody = getParametersData(parameters: parameters)
        }
        sendRequest(request, params: parameters, callBack: callBack)
    }

    private static func sendRequest(_ request: URLRequest, params :[String: Any],  callBack:@escaping (Bool,JSON?,String, Int)->Void)
    {
        let parm = params.keys.count>0 ? params : nil
        let url = request.url!
        let mt = request.httpMethod == "POST" ? HTTPMethod.post : HTTPMethod.get
        Alamofire.request(url, method: mt, parameters: parm, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
            
            switch response.result {
                
            case .success( _):
                print("success")
                getCookie(response: response)
                
                handleSuccessResponse(response, callBack: callBack)
                
            case .failure(let error):
                print("error on connect: \(error)")
                //handleFailureResponse(response, error:error, callBack: callBack)
                
            }
        }
    }
    
    private static func handleSuccessResponse(_ response: DataResponse<Any>, callBack:@escaping (Bool,JSON?,String, Int)->Void){
        
        let statusCode = (response.response?.statusCode) ?? 1
        let json = JSON(response.result.value!)
        callBack(true, json, "", statusCode)
        
    }
    
    
}

//
//    static func modelRequest(api:String, parameters:[String: Any?], methodType:String = "post", callBack:@escaping (DRO<T>)->Void){
//
//        let paramas = parameters
//        handleRequest(api: api, parameters: paramas, methodType: methodType){success, json, message, statusCode in
//
//            if success{
//
//                if  ((json?["status"].exists())! && (json?["message"].exists())! && (json?["status"].rawString() == "false" )) {
//
//                    let status = json?["status"].boolValue
//                    let apiMessage = ApiMessage(json: json!)
//                    apiMessage.statusCode = statusCode
//                    let dro = DRO<T>(success: true, status: status!, apiMessage:apiMessage)
//                    callBack(dro)
//
//                }else{
//
//                    let model = T(json: json!)
//                    let dro = DRO<T>(success: true, status: true, model:model, message:"")
//                    callBack(dro)
//                }
//
//            }else{
//                let dro = DRO<T>(success: false, message: message)
//                callBack(dro)
//            }
//
//        }
//
//    }
//
//    //#########
//
//    private static func handleError(error: Error, statusCode:Int)->String{
//
//        var message = ""
//
//        if let error = error as? AFError {
//            switch error {
//            case .invalidURL(let url):
//                message = "Invalid URL: \(url) - \(error.localizedDescription)"
//            case .parameterEncodingFailed(let reason):
//                message = "Parameter encoding failed: \(error.localizedDescription)"
//                message += " Failure Reason: \(reason)"
//            case .multipartEncodingFailed(let reason):
//                message = "Multipart encoding failed: \(error.localizedDescription)"
//                message += " Failure Reason: \(reason)"
//            case .responseValidationFailed(let reason):
//                message = "Response validation failed: \(error.localizedDescription)"
//                message += " Failure Reason: \(reason)"
//            case .responseSerializationFailed(let reason):
//                message = "Response serialization failed: \(error.localizedDescription)"
//                message += " Failure Reason: \(reason)"
//            }
//            let unerlineError = error.underlyingError
//            message = "Underlying error: \(String(describing: unerlineError))"
//
//        } else if let error = error as? URLError {
//
//            message = "URLError occurred: \(error)"
//        } else {
//
//            message = "Unknown error: \(error)"
//        }
//
//        return "Error Code is: \(statusCode) -> Error Message:" + message
//    }
//
//    private static func getMethodType(methodType: String)->HTTPMethod{
//
//        var type = HTTPMethod.post
//
//        switch methodType {
//        case "get":
//            type = .get
//
//        case "delete":
//            type = .delete
//        case "put":
//            type = .put
//
//        default:
//            type = .post
//        }
//
//        return type
//    }
//
//    static func handleRequest(api:String, parameters:[String: Any], methodType:String, arrayParam:[Any] = [], callBack:@escaping (Bool,JSON?,String, Int)->Void){
//
//        var request = setRequestByApi(api)
//        request.allHTTPHeaderFields = setHeader()
//        request.httpMethod = getMethodType(methodType: methodType).rawValue
//        request.httpBody = setParametersFor(parameters: parameters, arrayParam: arrayParam)
//
//        sendRequest(request, callBack: callBack)
//    }
//
//    private static func sendRequest(_ request: URLRequest,  callBack:@escaping (Bool,JSON?,String, Int)->Void)
//    {
//        Alamofire.request(request).responseJSON() { response in
//
//            switch response.result {
//
//            case .success( _):
//                handleSuccessResponse(response, callBack: callBack)
//
//            case .failure(let error):
//                handleFailureResponse(response, error:error, callBack: callBack)
//
//            }
//        }
//    }
//
//    private static func handleFailureResponse(_ response: DataResponse<Any>, error:Error, callBack:@escaping (Bool,JSON?,String, Int)->Void){
//
//        let statusCode = (response.response?.statusCode) ?? 0
//        let message = handleError(error: error, statusCode: statusCode)
//        callBack(false, JSON.null, message, statusCode)
//    }
//
//    private static func handleSuccessResponse(_ response: DataResponse<Any>, callBack:@escaping (Bool,JSON?,String, Int)->Void){
//
//        let statusCode = (response.response?.statusCode) ?? 1
//
//        let json = JSON(response.result.value!)
//        callBack(true, json, "", statusCode)
//        print(json)
//    }
//
//}
//
