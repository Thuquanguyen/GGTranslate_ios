//
//  APIClient.swift
//  LuckyBest
//
//  Created by Tuyen on 2/25/19.
//  Copyright © 2019 Tuyen. All rights reserved.
//

import UIKit
import Alamofire

class APIClient: NSObject {
    static var shared = APIClient()
    
    var headers:HTTPHeaders = [
        "Content-Type":"application/json","service-api-key":"",
        "service-session-id":""
    ]
    
    func request(domain:String,path: String, params: Parameters!,completion: @escaping (_ result:ResultRequest) -> ())  {
        // Set timeout for 3'
       // let manager = Alamofire.SessionManager.default
        //manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: "\(domain)\(path)")
       
        AF.request(url!, method: .post, parameters: params, encoding: URLEncoding.default, headers: self.headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let dict = value as? [String:Any] {
                    let result = ResultRequest(JSON: dict)
                    completion(result!)
                }
                else
                {
 
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestObjectJSON(domain:String,path: String,  params: Parameters!,completion: @escaping (_ result:[String:Any]) -> ())  {
        // Set timeout for 3'
        
       // let manager = AF.SessionManager.default
        
//        let manager = Alamofire.SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies:["https://luckybets.vn":.disableEvaluation]))
        
       // manager.session.configuration.timeoutIntervalForRequest = 120
        
        let url = URL(string: "\(domain)\(path)")
            AF.request(url!, method: .post, parameters: params, encoding:URLEncoding.default, headers: nil).responseJSON { (response) in
                print(self.headers)
                switch response.result {
                case .success(let value):
                    if let dict = value as? [String:Any] {
                        if let a = ResultRequest(JSON: dict){
                            completion((a.data!))
                        }else{
                             let fail: [String: Any] = [
                                                       "fail":false
                                                   ]
                                                   completion(fail)
                        }
                       
                    }
                    else
                    {
                         let fail: [String: Any] = [
                            "fail":false
                        ]
                        completion(fail)
                    }
                case .failure(let error):
                    print(error)
                    let fail: [String: Any] = [
                        "fail":false
                    ]
                    completion(fail)
                }
            }
        
    }
    
    func requestJSON(domain:String,path: String, params: Parameters!,completion: @escaping (_ result:ResultRequest) -> ())  {
        // Set timeout for 3'
//        let manager = Alamofire.SessionManager.default
//        manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: "\(domain)\(path)")
        
        AF.request(url!, method: .post, parameters: params, encoding:URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let dict = value as? [String:Any] {
                    let result = ResultRequest(JSON: dict)
                    completion(result!)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestJSONPoin(path: String, params: Parameters!,completion: @escaping (_ result:ResultRequest) -> ())  {
        // Set timeout for 3'
//        let manager = Alamofire.SessionManager.default
//        manager.session.configuration.timeoutIntervalForRequest = 120
        let url = URL(string: path)
        
        AF.request(url!, method: .post, parameters: params, encoding:URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let dict = value as? [String:Any] {
                    let result = ResultRequest(JSON: dict)
                    completion(result!)
                }
                else
                {

                }
            case .failure(let error):
                print(error)

            }
        }
    }
    


    
    
 
}
