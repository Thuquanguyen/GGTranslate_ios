//
//  Model.swift
//  Translator
//
//  Created by Intel on 10/19/19.
//  Copyright © 2019 Intel. All rights reserved.
//

import UIKit

class Model:NSObject, NSCoding {
    var example:String!
    var flag:String
    var fullName:String
    var voice:String!
    
    init(example:String,flag:String,fullName:String,voice:String){
        self.example = example
        self.flag = flag
        self.fullName = fullName
        self.voice = voice
    }
    //MARK: - NSCoding -
    required convenience init(coder aDecoder: NSCoder) {
        let example = aDecoder.decodeObject(forKey: "example") as? String ?? ""
        let flag = aDecoder.decodeObject(forKey: "flag") as? String ?? ""
        let fullName = aDecoder.decodeObject(forKey: "fullName") as? String ?? ""
        let voice = aDecoder.decodeObject(forKey: "voice") as? String ?? ""
        self.init(example:example,flag:flag,fullName:fullName,voice:voice)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(example, forKey: "example")
        aCoder.encode(flag, forKey: "flag")
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(voice, forKey: "voice")
    }
}
