//
//  ParseTranslate.swift
//  Translator
//
//  Created by Intel on 10/21/19.
//  Copyright © 2019 Intel. All rights reserved.
//

import UIKit
import  Alamofire

class ParseTranslate {
    typealias CompletionHandler = (_ ArrayTranslations:AnyObject, _ Success:Bool) -> Void
    var key  = "AIzaSyDDnL1ja6pG5LNLhu_FV_blJd-nT6GZyEQ"
    class var sharedInstance : ParseTranslate {
        struct Static {
            static let instance : ParseTranslate = ParseTranslate()
        }
        return Static.instance
    }
    var arrayTranslation = Array<Translation>()
    func requestObjectJSON(domain:String,path: String, params: Parameters!,completion: @escaping (_ result:[String:Any]) -> ())  {
        // Set timeout for 3'
     
        
        let url = URL(string: "\(domain)\(path)")
        
        AF.request(url!, method: .post, parameters: params, encoding:URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let dict = value as? [String:Any] {
                    _ = ResultRequest(JSON: dict)
                    completion(dict)
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
}
