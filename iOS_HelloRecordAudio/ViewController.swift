//
//  ViewController.swift
//  iOS_HelloRecordAudio
//
//  Created by 王麒翔 on 2023/7/20.
//

import UIKit
import AVFoundation

enum AudioSessionMode {
    case record
    case play
}

class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var isRecording = false

    @IBAction func recordAudio(_ sender: UIButton) {
        settingAudioSession(toMode: .record)
        audioRecorder?.prepareToRecord()
        audioRecorder?.record() // 開始錄音
        isRecording = true
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        audioRecorder?.stop() // 停止錄音
        isRecording = false
        settingAudioSession(toMode: .play)
    }
    
    @IBAction func playRecordedSound(_ sender: UIButton) {
    }
    
    @IBAction func stopPlaying(_ sender: UIButton) {
    }
    
    // 音訊工作階段
    func settingAudioSession(toMode mode: AudioSessionMode){
        let session = AVAudioSession.sharedInstance()
        
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
    
    // 實作 AVAudioRecorderDelegate func
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag == true {
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: recorder.url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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

