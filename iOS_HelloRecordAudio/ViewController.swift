//
//  ViewController.swift
//  iOS_HelloRecordAudio
//
//  Created by 王麒翔 on 2023/7/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var isRecording = false

    @IBAction func recordAudio(_ sender: UIButton) {
    }
    @IBAction func stopRecording(_ sender: UIButton) {
    }
    @IBAction func playRecordedSound(_ sender: UIButton) {
    }
    @IBAction func stopPlaying(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // init an audio recorder
        let filename = "User.wav"
        let path = NSHomeDirectory() + "/Documents/" + filename
        let url = URL(fileURLWithPath: path)
        let recordSettings: [String:Any] = [
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: recordSettings)
        } catch {
            print(error.localizedDescription)
        }
    }


}

