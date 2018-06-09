//
//  AlamofireClient.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireClient {
    // MARK: - Shared Instance
    static let sharedInstance =  AlamofireClient()
    
    private init() {
    }
    
    func getRequest(path: String, parameters: [String: Any]?, completion:@escaping (Data?, Error?) -> Void) {
        
        ActivityIndicator().show()
        
        let url = Constants.baseURL + path + "&units=metric&appid=" + Constants.apiKey
        
        Alamofire.request(url, parameters: parameters, headers: nil).responseJSON { response in
            ActivityIndicator().hide()
            let statusCode = response.response?.statusCode
            print(statusCode ?? "statusCode default value")
            
            guard response.result.isSuccess else {
                print("Error while fetching : \(String(describing: response.result.error))")
                return
            }
            
            guard statusCode == 200, response.result.error == nil else {
                completion(nil, response.result.error)
                return
            }
            completion(response.data, nil)
            
        }
    }
    
    func downloadImageWith(icon: String,completion:@escaping (UIImage?, Error?) -> Void){
        let url:String = "\(Constants.iconsBaseURL)\(icon).png"
        Alamofire.request(url).responseData(completionHandler: { response in
            if let imageData = response.result.value {
                let image = UIImage(data: imageData)
                completion(image,response.error)
            }
            completion(nil,response.error)
        })
    }
}
