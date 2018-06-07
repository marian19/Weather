//
//  AlamofireClient.swift
//  Blends
//
//  Created by Marian on 12/21/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireClient: APIClient {
    // MARK: - Shared Instance
    static let sharedInstance =  AlamofireClient()
    private init() {
    }
    func getRequest(path: String, parameters: [String: Any]?, completion:@escaping (Data?, Error?) -> Void) {
        ActivityIndicator().show()
        
        let headers = getHeaders()
        
        Alamofire.request(Constants.baseURL + path, parameters: parameters, headers: headers).responseJSON { response in
            ActivityIndicator().hide()
                        print(response.request?.url)
            let statusCode = response.response?.statusCode
            print(statusCode ?? "statusCode default value")
            
            guard response.result.isSuccess else {
                print("Error while fetching : \(String(describing: response.result.error))")
                return
            }
            
            guard statusCode == 200, response.result.error == nil else {
                ErrorHandling.handleErrorCode(responseData: response.data!)
                return
            }
            //            let json = try JSON(data: response.data!)
            do{
                var responseJson = try JSONSerialization.jsonObject(with: response.data!, options: []) as? Dictionary<String, Any>
            print(responseJson)
            }catch{
                
            }
            completion(response.data, nil)
            
        }
    }
    func postRequest(path: String, parameters: [String: Any]?, completion:@escaping (Data?, Error?) -> Void) {
        ActivityIndicator().show()
        
        let headers = getHeaders()
        print(Constants.baseURL + path)
        Alamofire.request(Constants.baseURL + path, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers ).responseJSON{ response in
            ActivityIndicator().hide()
            
            let statusCode = response.response?.statusCode
            print(statusCode ?? "statusCode default value")
            
            guard response.result.isSuccess else {
                print("Error while fetching : \(String(describing: response.result.error))")
                return
            }
            
            guard statusCode == 200, response.result.error == nil else {
//                do {
                    ErrorHandling.handleErrorCode(responseData: response.data!)
                    return
//                }catch{
//                    print(error)
//                    return
//                }
            }
            
            //            let json = try JSON(data: response.data!)
            do{
            var responseJson = try JSONSerialization.jsonObject(with: response.data!, options: []) as? Dictionary<String, Any>
            print(responseJson)
            }catch{
                
            }
            completion(response.data, nil)
            
        }
    }
    
    private func getHeaders() -> [String: String]{
        
        var headers: [String : String] = ["X-Oc-Merchant-Id": Constants.SecretKey]
        if let sessionKey = UserDefaults.standard.object(forKey: DataConstants.SessionData.sessionKey) as? String {
            headers.updateValue(sessionKey, forKey: "X-Oc-Session")
            
        }
        if let language = UserDefaults.standard.object(forKey: DataConstants.SettingData.languageCode) as? String {
            headers.updateValue(language, forKey: "X-Oc-Merchant-Language")
            
        }
        if let currency = UserDefaults.standard.object(forKey: DataConstants.SettingData.currencyCode) as? String {
            headers.updateValue(currency, forKey: "X-Oc-Currency")
            
        }
        
        return headers
        
    }
    
    func putRequest(path: String, parameters: [String: Any]?, completion:@escaping (Data?, Error?) -> Void){
        ActivityIndicator().show()
        
        let headers = getHeaders()
        
        Alamofire.request(Constants.baseURL + path, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers ).responseJSON{ response in
            ActivityIndicator().hide()
            
            let statusCode = response.response?.statusCode
            print(statusCode ?? "statusCode default value")
            
            guard response.result.isSuccess else {
                print("Error while fetching : \(String(describing: response.result.error))")
                return
            }
            
            guard statusCode == 200, response.result.error == nil else {
                ErrorHandling.handleErrorCode(responseData: response.data!)
                return
            }
            //            let json = try JSON(data: response.data!)
            do{
                var responseJson = try JSONSerialization.jsonObject(with: response.data!, options: []) as? Dictionary<String, Any>
                print("PUT: ")
                print(responseJson)
            }catch{
                
            }
            completion(response.data, nil)
            
        }
    }
    
    
    func deleteRequest(path: String, parameters: [String: Any]?, completion:@escaping (Data?, Error?) -> Void){
        ActivityIndicator().show()
        
        let headers = getHeaders()
        print(Constants.baseURL + path)

        Alamofire.request(Constants.baseURL + path, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers ).responseJSON{ response in
            ActivityIndicator().hide()
            
            let statusCode = response.response?.statusCode
            print(statusCode ?? "statusCode default value")
            
            guard response.result.isSuccess else {
                print("Error while fetching : \(String(describing: response.result.error))")
                return
            }
            
            guard statusCode == 200, response.result.error == nil else {
                ErrorHandling.handleErrorCode(responseData: response.data!)
                return
            }
            do{
                var responseJson = try JSONSerialization.jsonObject(with: response.data!, options: []) as? Dictionary<String, Any>
                print(responseJson)
            }catch{
                
            }
            //            let json = try JSON(data: response.data!)
            completion(response.data, nil)
            
        }
    }
}
