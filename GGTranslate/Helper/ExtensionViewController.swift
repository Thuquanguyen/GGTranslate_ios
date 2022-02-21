//
//  ExtensionViewController.swift
//  Theory UK
//
//  Created by Intel on 12/1/20.
//  Copyright © 2020 IntelD. All rights reserved.
//

import UIKit
import Speech
import Firebase
struct Indicator {
    
    static var indicator:UIView!
    static var indicatorLoading:UIView!
    static var  synth = AVSpeechSynthesizer()
    static var  myUtterance = AVSpeechUtterance(string: "")
    static var vision = Vision.vision()
    static var nap  = Vision.vision().cloudImageLabeler()
    static var txtRecognizer = Vision.vision().cloudTextRecognizer()
}
extension UIViewController{
    typealias CompletionHandler = (_ ArraySTR:Array<String>, _ Success:Bool) -> Void
    
    func alertError(mess:String) {
        let alertController = UIAlertController(title: "Alert", message: mess, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func removeIndicatorLoading(){
        Indicator.indicatorLoading.removeFromSuperview()
    }
    func stopSpeak(){
            Indicator.synth.stopSpeaking(at: AVSpeechBoundary.word)
        }

    func Speak(str:String,language:String) {
        
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print(error)
        }
        Indicator.synth.stopSpeaking(at: AVSpeechBoundary.word)
        
        Indicator.myUtterance = AVSpeechUtterance(string: str)
        Indicator.myUtterance.voice = AVSpeechSynthesisVoice(language: language)
        Indicator.myUtterance.rate = Float(0.4)
        Indicator.synth.speak(Indicator.myUtterance)
    }
    
    func createIndicatorLoading(){
        Indicator.indicatorLoading = UIView()
        Indicator.indicatorLoading.frame.size = CGSize(width: 150, height: 75)
        Indicator.indicatorLoading.center = self.view.center
        Indicator.indicatorLoading.layer.cornerRadius = 10
        Indicator.indicatorLoading.layer.Shadow(color: .black)
        Indicator.indicatorLoading.layer.masksToBounds = true
        Indicator.indicatorLoading.backgroundColor = UIColor.white
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.color = UIColor.black
        activityView.center = CGPoint(x: 75, y: 37.5)
        Indicator.indicatorLoading.addSubview(activityView)
        self.view.addSubview(Indicator.indicatorLoading)
        activityView.startAnimating()
    }
    
    func Translate(str:String){
        
    }
    func shareText(str:String){
        
        let objectsToShare = [str]
        let activityController = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)
        if let popoverController = activityController.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        self.present(activityController, animated: true, completion: nil)
    }
    
    
    func getTextFormSign(image:UIImage , completionHandler: @escaping CompletionHandler){
        var arrayString = Array<String>()
        self.createIndicatorLoading()
        let visionImg = VisionImage(image:image)
        Indicator.nap.process(visionImg) { labels, error in
            print(error)
            guard error == nil, let labels = labels else { return }
            if labels.count > 0{
                var str = ""
                for (ind,label) in labels.enumerated() {
                    if ind == 0 {
                        str = "\(label.text)"
                    }else{
                        str = "\(str) || \(label.text)"
                    }
                }
                arrayString = str.components(separatedBy: "||")
                
                self.removeIndicatorLoading()
                
                completionHandler(arrayString,true)
                
            }
            
            
        }
    }
    func pushVC(){
        
    }
    func detectText(image:UIImage, completionHandler: @escaping CompletionHandler){
        self.createIndicatorLoading()
        let visionImg = VisionImage(image: image)
        Indicator.txtRecognizer.process(visionImg) { (result, err) in
            guard err == nil , let result = result else{
                
                self.removeIndicatorLoading()
                return
            }
            if result.blocks.count > 0{
                var txt = ""
                for i in result.blocks{
                    if i.text == "sdsjdlskjdlsjdlskjdsdsdsdsd"{
                        
                    }
                    if i.text == "sdsjdlskjdlsjdlskjd"{
                        
                    }
                    if i == result.blocks.first{
                        txt = "\(i.text)"
                    }else{
                        txt = "\(txt) \n \(i.text)"
                    }
                }
                
                self.removeIndicatorLoading()
                completionHandler([txt],true)
            }else{
                
                self.removeIndicatorLoading()
            }
            
        }
        
        
        
        
        
    }
    func shareVideoAndPhoto(url:URL){
             let objectsToShare = [url]
             let activityController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
             if let popoverController = activityController.popoverPresentationController {
                 popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                 popoverController.sourceView = self.view
                 popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
             }
             self.present(activityController, animated: true, completion: nil)
         }
   


    
    
    
    
    
}


public extension CALayer  {
    func connerRadius(_ radius:Float){
        self.cornerRadius = CGFloat(radius)
        self.masksToBounds = true
    }
    func Shadow(color:UIColor){
        self.shadowColor = color.cgColor
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowRadius = 5
        self.shadowOpacity = 0.5
    }
    
}
extension UIViewController{
    
   
}



extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension UIViewController {
    
    func shareTextToWhatsapp(str:String){
        let urlWhats = "whatsapp://send?text=\(str)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
              if let whatsappURL = NSURL(string: urlString) {
                    if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                         UIApplication.shared.open(whatsappURL as URL)
                     }
                     else {
                        self.alertError(mess: "Please Install Whatsapp to use this feature")
                     }
              }
        }
    }
    
    
}
