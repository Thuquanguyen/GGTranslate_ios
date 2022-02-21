//
//  TranslateModel.swift
//  Translator
//
//  Created by Intel on 10/21/19.
//  Copyright © 2019 Intel. All rights reserved.
//

import UIKit

class TranslateModel: Translation  {
    override init(isCheckTranslate: Bool, id: String, flag: String, translatedText: String, dectededLanguage: String,voice:String) {
        super.init(isCheckTranslate: isCheckTranslate, id: id, flag: flag, translatedText: translatedText, dectededLanguage: dectededLanguage,voice:voice)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
