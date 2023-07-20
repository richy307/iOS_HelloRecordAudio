//
//  RecordHelper.swift
//  iOS_HelloRecordAudio
//
//  Created by 王麒翔 on 2023/7/20.
//

import Foundation
import AVFoundation

class RecordHelper: NSObject, AVAudioRecorderDelegate {
    
    // 屬性
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var isRecording = false
    
    
    func recordAudio() {
        settingAudioSession(toMode: .record)
        audioRecorder?.prepareToRecord()
        audioRecorder?.record() // 開始錄音
        isRecording = true
    }
    
    func stopRecording() {
        audioRecorder?.stop() // 停止錄音
        isRecording = false
        settingAudioSession(toMode: .play)
    }
    
    func playRecordedSound() {
        if isRecording == false {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
            audioPlayer?.play()
        }
    }
    
    func stopPlaying() {
        if isRecording == false {
            audioPlayer?.stop()
            audioPlayer?.currentTime = 0
        }
    }
    
    // 實作 AVAudioRecorderDelegate func // 錄音好會呼叫
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag == true {
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: recorder.url) // 已經錄音好的音樂檔案位置
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // 音訊工作階段
    func settingAudioSession(toMode mode: AudioSessionMode){
        let session = AVAudioSession.sharedInstance() // 用來與 OS Device 做溝通
        
        do {
            switch mode {
            case .record:
                try session.setCategory(.playAndRecord, mode: .default, options: [])
            case .play:
                try session.setCategory(.playback, mode: .default, options: [])
            }
            try session.setActive(false)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override init() {
        super.init()
        
        // init an audio recorder
        let filename = "User.wav" // 檔名
        let path = NSHomeDirectory() + "/Documents/" + filename // 儲存路徑
        let url = URL(fileURLWithPath: path)
        
        // 錄音設定
        let recordSettings: [String:Any] = [
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recordSettings)
            audioRecorder?.delegate = self // 實作介面
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
