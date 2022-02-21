//
//  ResponseData.swift
//  LuckyBest
//
//  Created by Tuyen on 2/25/19.
//  Copyright © 2019 Tuyen. All rights reserved.
//

import UIKit

enum TypeRequest:Int {
    case success = 0
    case fail = 400
}

class ResponseData: NSObject {
    static var shared = ResponseData()
    var key = "AIzaSyDDnL1ja6pG5LNLhu_FV_blJd-nT6GZyEQ"
    func getInfo(q:String,target:String,completion: @escaping (_ insta:[TranslatedModel],_ status:TypeRequest) -> ())
    {
        
        APIClient.shared.requestObjectJSON(domain: "https://translation.googleapis.com/language/translate/v2", path: "", params: ["q":q,"target":target,"key":key,"format":"text"]) { (result) in
            var q = BaseModel()
            if result != nil
            {
                q = BaseModel(JSON: result)!
                if q.data.count > 0 {
                     completion(q.data,.success)
                }else{
                      completion(q.data,.fail)
                }
               
            }
            else
            {
                completion(q.data,.fail)
            }
        }
    }
    
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
