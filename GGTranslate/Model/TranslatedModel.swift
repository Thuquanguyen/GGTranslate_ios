//
//  TranslatedModel.swift
//  Translator
//
//  Created by Intel on 10/21/19.
//  Copyright © 2019 Intel. All rights reserved.
//

import UIKit
import ObjectMapper
class TranslatedModel: Translation, Mappable {
    var map2:Map!
    
    override init(isCheckTranslate: Bool, id: String, flag: String, translatedText: String, dectededLanguage: String,voice:String) {
        
        super.init(isCheckTranslate: isCheckTranslate, id: id, flag: flag, translatedText: translatedText, dectededLanguage: dectededLanguage,voice:voice)
        
    }
    required convenience init?(map: Map) {
        self.init(isCheckTranslate: false , id: "", flag: "", translatedText: "", dectededLanguage: "",voice : "")
    }
    func mapping(map: Map)
    {
        translatedText <- map["translatedText"]
        dectededLanguage <- map["dectededLanguage"]
        self.translatedText = translatedText.htmlDecoded
    }
    
    override init() {
        super.init()
    }
}
extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string
        
        return decoded ?? self
    }
}
