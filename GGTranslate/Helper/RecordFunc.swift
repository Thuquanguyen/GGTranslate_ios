//
//  RecordFunc.swift
//  TranslatePro
//
//  Created by Intel on 11/21/19.
//  Copyright © 2019 Intel. All rights reserved.
//

import UIKit
import AVFoundation
import Speech
extension VoiceVC{
    func startRecording() {
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            
            synth.stopSpeaking(at: AVSpeechBoundary.word)
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        recognitionRequest.shouldReportPartialResults = true  //6
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: {
            (result, error) in  //7
            if self.timerFinish != nil {
                self.timerFinish?.invalidate()
                self.timerFinish = nil
            }
            var isFinal = false  //8
            if result != nil {
                if self.checkStopRecord {return}
                self.stringVoice = result?.bestTranscription.formattedString ?? ""
                self.timerFinish = Timer.scheduledTimer(timeInterval: 3, target: self,   selector: (#selector(self.StopTimer)), userInfo: nil, repeats: false)
                self.txtView.text = result?.bestTranscription.formattedString ?? ""
                //self.updateSizeView()
                
                
                isFinal = (result?.isFinal)!
                
            }
        })
        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()  //12
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            
        } else {
            
        }
    }
    @objc func StopTimer(){
        
    }
    func speakWith(text:String,language:String){
        print(language)
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print(error)
        }
        synth.stopSpeaking(at: AVSpeechBoundary.word)
        
        myUtterance = AVSpeechUtterance(string: text)
        myUtterance.voice = AVSpeechSynthesisVoice(language: language)
        myUtterance.rate = Float(0.4)
        if detectLanguageSupported(language: language){
            synth.speak(myUtterance)
        }
        
    }
    func detectLanguageSupported(language:String) -> Bool{
        for voice in  AVSpeechSynthesisVoice.speechVoices(){
            if language == voice.language{
                return true
            }
        }
        return false
        
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
