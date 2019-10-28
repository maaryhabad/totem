//
//  ViewController.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 10/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage


class GravarViewController: UIViewController, AVAudioRecorderDelegate {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    @IBOutlet weak var gravarBotao: UIButton!
    var audioFileName: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        recordingSession = AVAudioSession.sharedInstance()
        gravarBotao.isEnabled = false
        // permissão do usuário para usar o microfone

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.gravarBotao.isEnabled = true
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
        
    }
    

    
    func startRecording() {
        // onde o áudio fica salvo
        self.audioFileName = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        // configurações do áudio
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        //iniciar gravação

        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            gravarBotao.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            gravarBotao.setTitle("Tap to Re-record", for: .normal)
        } else {
            gravarBotao.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        //[file:///var/mobile/Containers/Data/Application/700F0F82-41F1-4F1A-B5A2-771001BF9B1B/Documents/]

        print(paths)
        return paths[0]
    }
    
    
// MARK: Gravar Áudio
    @IBAction func gravarAudio(_ sender: Any) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
        
    }
    
    @IBAction func playAudio(_ sender: Any) {
//        let path = Bundle.main.path(forResource: audioFileName, ofType: nil)!
//        let url = URL(fileURLWithPath: path)
        
        //aqui ele troca o output de áudio pro speaker
        do {
            try recordingSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch let error as NSError {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        //aqui ele dá play no áudio
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            audioPlayer.play()
        } catch {
            print("arquivo não encontrado")
        }
    }
    
    
    
    // MARK: Firestore
    

    @IBAction func apertouSalvar(_ sender: Any) {
        
        let storage = Storage.storage()
        // Data in memory
        let data = Data()
        let storageRef = storage.reference()

        // Create a reference to the file you want to upload
        let audioRef = storageRef.child("audios/recording.m4a")

        // Upload the file to the path "audios/recording.m4a"
        let uploadTask = audioRef.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            print("Aconteceu um erro na metadata")
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          audioRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                print("Aconteceu um erro no link de download")
              // Uh-oh, an error occurred!
              return
            }
          }
            print("acho que deu boa")
        }
    }
    
}

