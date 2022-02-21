//
//  Utils.swift
//  LuckyBest
//
//  Created by Tuyen on 3/2/19.
//  Copyright © 2019 Tuyen. All rights reserved.
//

import UIKit
import Foundation

class Utils {
    static var shared = Utils()
    var keyLanguage1 = "language1"
    var keyLanguage2 = "language2"
    var arrayItem = [Model(example: "إدخال اللغة إلى الكلام ", flag: "Saudi Arabia", fullName: "Arabic (Saudi Arabia)", voice: "ar-SA"), Model(example: "输入你的语言到语音", flag: "China", fullName: "Chinese (China)", voice: "zh-CN"),Model (example: "輸入你的語言到語音", flag: "Hong Kong", fullName: "Chinese (Hong Kong SAR China)", voice: "zh-HK"), Model(example: "輸入你的語言到語音", flag: "Taiwan", fullName: "Chinese (Taiwan)", voice: "zh-TW"), Model(example: "zadejte svůj jazyk do řeči", flag: "Czech Republic", fullName: "Czech (Czech Republic)", voice: "cs-CZ"), Model(example: "Indtast dit sprog til tale", flag: "Denmark", fullName: "Danish (Denmark)", voice: "da-DK"), Model(example: "voer je taal in voor spraak", flag: "Belgium", fullName: "Dutch (Belgium)", voice: "nl-BE"),Model(example: "voer je taal in voor spraak", flag: "Netherlands", fullName: "Dutch (Netherlands)", voice: "nl-NL"),  Model(example: "input your language to speech", flag: "United States", fullName: "English (United States)", voice: "en-US"), Model(example: "anna kielen puheeksi", flag: "Finland", fullName: "Finnish (Finland)", voice: "fi-FI"), Model(example: "input your language to speech", flag: "Canada", fullName: "French (Canada)", voice: "fr-CA"), Model(example: "entrer votre langue à la parole", flag: "France", fullName: "French (France)", voice: "fr-FR"), Model(example: "εισάγετε τη γλώσσα σας στην ομιλία σας", flag: "Germany", fullName: "German (Germany)", voice: "de-DE"), Model(example: "Gib deine Sprache in Sprache ein", flag: "Greece", fullName: "Greek (Greece)", voice: "el-GR"), Model(example: "קלט את השפה שלך לדיבור", flag: "Israel", fullName: "Hebrew (Israel)", voice: "he-IL"), Model(example: "अपनी भाषा को भाषण में इनपुट करें", flag: "India", fullName: "Hindi (India)", voice: "hi-IN"), Model(example: "adja meg nyelvét beszédhez", flag: "Hungary", fullName: "Hungarian (Hungary)", voice: "hu-HU"), Model(example: "masukan bahasa Anda ke ucapan", flag: "Indonesia", fullName: "Indonesian (Indonesia)", voice: "id-ID"), Model(example: "inserisci la tua lingua per parlare", flag: "Italy", fullName: "Italian (Italy)", voice: "it-IT"), Model(example: "スピーチにあなたの言語を入力する", flag: "Japan", fullName: "Japanese (Japan)", voice: "ja-JP"), Model(example: "연설에 당신의 언어를 입력하십시오", flag: "South Korea", fullName: "Korean (South Korea)", voice: "ko-KR"), Model(example: "skriv inn språket ditt til tale", flag: "Norway", fullName: "Norwegian (Norway)", voice: "no-NO"), Model(example: "wprowadź swój język na mowę", flag: "Poland", fullName: "Polish (Poland)", voice: "pl-PL"), Model(example: "insira seu idioma para falar", flag: "Brazil", fullName: "Portuguese (Brazil)", voice: "pt-BR"), Model(example: "insira seu idioma para falar", flag: "Portugal", fullName: "Portuguese (Portugal)", voice: "pt-PT"), Model(example: "introduceți limba în vorbire", flag: "Romania", fullName: "Romanian (Romania)", voice: "ro-RO"), Model(example: "введите свой язык в речь", flag: "Russia", fullName: "Russian (Russia)", voice: "ru-RU"), Model(example: "vložte svoj jazyk do reči", flag: "Slovakia", fullName: "Slovak (Slovakia)", voice: "sk-SK"), Model(example: "ingrese su lenguaje al habla", flag: "Mexico", fullName: "Spanish (Mexico)", voice: "es-MX"), Model(example: "ingrese su lenguaje al habla", flag: "Spain", fullName: "Spanish (Spain)", voice: "es-ES"), Model(example: "skriv in ditt språk till tal", flag: "Sweden", fullName: "Swedish (Sweden)", voice: "sv-SE"), Model(example: "ใส่ภาษาของคุณเป็นคำพูด", flag: "Thailand", fullName: "Thai (Thailand)", voice: "th-TH"), Model(example: "konuşma dilini girdin", flag: "Turkey", fullName: "Turkish (Turkey)", voice: "tr-TR"),Model(example: "Xin Chào", flag: "Viet Nam", fullName: "Vietnamese", voice: "vi-VN")]
    typealias CompletionHandler = (_ lang1:Model, _ lang2:Model , _ suc:Bool) -> Void
    func getLanguage(completionhandler: @escaping CompletionHandler ) {
        let defaults = UserDefaults.standard
         if let decoded  = defaults.data(forKey: keyLanguage1) {
            let decodedInfo1 = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Model
            let decodedInfo2 = NSKeyedUnarchiver.unarchiveObject(with: defaults.data(forKey: keyLanguage2)!) as! Model
            completionhandler(decodedInfo1,decodedInfo2,true)
         }else{
            self.saveData1(lang1: self.arrayItem[12])
            self.saveData2(lang2: self.arrayItem[33])
            completionhandler(self.arrayItem[12],self.arrayItem[33],true)
        }
         
    }
    func saveData1(lang1:Model){
      let userDefaults = UserDefaults.standard
        let encodedData1: Data = NSKeyedArchiver.archivedData(withRootObject: lang1)
       
        userDefaults.set(encodedData1, forKey: keyLanguage1)
         
        userDefaults.synchronize()
    }
    func saveData2(lang2:Model) {
          let userDefaults = UserDefaults.standard
         let encodedData2: Data = NSKeyedArchiver.archivedData(withRootObject: lang2)
        userDefaults.set(encodedData2, forKey: keyLanguage2)
          userDefaults.synchronize()
    }
    func getArrayItem() -> Array<Model>{
        return arrayItem
    }
    func swapLanguage(language1:Model,language2:Model,completionhandler: @escaping CompletionHandler){
        self.saveData1(lang1: language2)
        self.saveData2(lang2: language1)
        getLanguage { (lang1, lang2, suc) in
            completionhandler(lang1,lang2,true)
        }
        
    }
}
