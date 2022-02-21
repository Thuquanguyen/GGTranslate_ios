//
//  ResultRequest.swift
//  MumgoApp
//
//  Created by Tuyen on 2/25/19.
//  Copyright © 2019 Tuyen. All rights reserved.
//

import UIKit
import ObjectMapper

class ResultRequest: Mappable {
    
    var status: TypeRequest = .fail
    var resultDesc: String = ""
    var data: [String : Any]?
    var dataArray:[[String : Any]] = []
    var error:NSError!
    var dataString = ""
    var dataInt = 0
    var result = 400
    
    required convenience init?(map: Map) {
        self.init()
    }
    // Mappable
    func mapping(map: Map) {
        self.result <- map["result"]
        self.status = TypeRequest(rawValue:self.result) ?? .fail
        self.resultDesc <- map["resultDesc"]
        self.data <- map["data"]
        self.dataArray <- map["data"]
        self.dataString <- map["data"]
        self.dataInt <- map["data"]
        print(dataArray)
    }
}
