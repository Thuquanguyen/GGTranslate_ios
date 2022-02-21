//
//  Translation.swift
//  Translator
//
//  Created by Intel on 10/20/19.
//  Copyright © 2019 Intel. All rights reserved.
//

import UIKit
class Translation : NSCoding{
    
    
    var id:String!
    var translatedText:String!
    var dectededLanguage:String!
    var flag:String!
    var isCheckTranslate:Bool!
    var voice:String!
    init(isCheckTranslate:Bool,id:String,flag:String, translatedText:String , dectededLanguage:String,voice:String) {
        self.translatedText = translatedText
        self.dectededLanguage = dectededLanguage
        self.flag = flag
        self.id = id
        self.isCheckTranslate = isCheckTranslate
        self.voice = voice
    }
    init() {
        
    }
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(translatedText, forKey: "translatedText")
        coder.encode(dectededLanguage, forKey: "dectededLanguage")
        coder.encode(flag, forKey: "flag")
        coder.encode(isCheckTranslate, forKey: "isCheckTranslate")
        coder.encode(voice, forKey: "voice")
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        let translatedText = aDecoder.decodeObject(forKey: "translatedText") as? String ?? ""
        let dectededLanguage = aDecoder.decodeObject(forKey: "dectededLanguage") as? String ?? ""
        let flag = aDecoder.decodeObject(forKey: "flag") as? String ?? ""
        let isCheckTranslate = aDecoder.decodeObject(forKey: "isCheckTranslate") as? Bool ?? false
        let voice = aDecoder.decodeObject(forKey: "voice") as? String ?? ""
        self.init(isCheckTranslate:isCheckTranslate,id:id,flag:flag, translatedText:translatedText , dectededLanguage:dectededLanguage,voice:voice)
        
    }
}
