//
//  VoiceVC.swift
//  GGTranslate
//
//  Created by Apple on 16/01/2022.
//

import Foundation
import UIKit
import PulsingHalo
import AVFoundation
import Speech

class VoiceVC: UIViewController{
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var viewTxt: UIView!
    var checkStopRecord = false
    @IBOutlet weak var viewText: UIView!
    var speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "vi-VN"))!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var pulsing1 = PulsingHaloLayer()
    var pulsing2 = PulsingHaloLayer()
    var timerFinish:Timer?
    var stringVoice = ""
    var lang1:Model!
    var vcP:ViewController!
    
    @IBOutlet weak var lblLang: UILabel!
    @IBOutlet weak var btnVoice: UIButton!
    var isCheckVoice = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblLang.text = lang1.fullName.components(separatedBy: "(")[0]
        self.btnVoice.layer.connerRadius(35)
        self.viewTxt.layer.Shadow(color: UIColor.black)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionVoice(_ sender: Any) {
        isCheckVoice = !isCheckVoice
        if isCheckVoice{
            startMicro(language: self.lang1)
        }else{
            stopMicro()
        }
        //setPulsing()
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// handel Conflic
extension VoiceVC{
    func setConflic(){
        self.pulsing1 = PulsingHaloLayer()
               self.pulsing1.position = self.btnVoice.center
               self.pulsing1.radius = 75
               self.pulsing1.haloLayerNumber = 4
        self.pulsing1.backgroundColor = UIColor(hexString: "E84335").cgColor
               self.viewText.layer.addSublayer(self.pulsing1)
               self.pulsing1.start()
    }
}

// Handel Micro
extension VoiceVC{
    func startMicro(language:Model){
        self.setConflic()
        self.btnVoice.setImage(UIImage(named: "stop"), for: .normal)
        self.checkStopRecord = false
        self.stringVoice = ""
        if !audioEngine.isRunning {
            self.speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: language.voice))!
            self.startRecording()
        }
    }
    func stopMicro(){
        self.btnVoice.setImage(UIImage(named: "baseline_mic_black_48pt"), for: .normal)
        self.checkStopRecord = true
        if audioEngine.isRunning {
            recognitionRequest?.endAudio()
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            self.recognitionRequest = nil
            self.recognitionTask = nil
            if timerFinish != nil {
                timerFinish?.invalidate()
                timerFinish = nil
            }
        }
        self.pulsing1.removeFromSuperlayer()
        print(self.txtView.text)
        vcP.txtView.text = self.txtView.text
        vcP.getData(q: self.txtView.text, target: vcP.lang2)
        self.dismiss(animated: true, completion: nil)
        //self.getData(q: self.textVoice.text, target: self.lang2)
        
    }
}
