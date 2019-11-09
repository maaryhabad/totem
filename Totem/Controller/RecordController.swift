//
//  RecordController.swift
//  totem
//
//  Created by Mariana Beilune Abad on 09/11/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
import AVFoundation
import Firebase

class RecordController: AVAudioRecorderDelegate {
    
    
    var recordingSession = AVAudioSession()
    var audioRecorder = AVAudioRecorder()
    var audioPlayer = AVAudioPlayer()
    var audioFileName: URL
    
    init(recordingSession: AVAudioSession, audioRecorder: AVAudioRecorder, audioPlayer: AVAudioPlayer, audioFileName: URL) {
        self.recordingSession = recordingSession
        self.audioRecorder = audioRecorder
        self.audioPlayer = audioPlayer
        self.audioFileName = audioFileName
    }
    
    
    func prepareToRecord() {
            
    }
}
