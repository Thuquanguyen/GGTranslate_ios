//
//  BaseModel.swift
//  CoinCap
//
//  Created by Tuyen on 7/2/19.
//  Copyright © 2019 Tuyen. All rights reserved.
//

import UIKit
import ObjectMapper
class BaseModel: NSObject,Mappable {
    
    var data : [TranslatedModel] = []

    required convenience init?(map: Map) {
        self.init(data: [])
    }
    
    override init() {
        super.init()
    }

    func mapping(map: Map) {
        self.data <- map["translations"]
    }
    
    init(data: [TranslatedModel]) {
        self.data = data
    }
    
    //MARK: - NSCoding -
   
}

