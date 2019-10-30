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
import Firebase


class GravarViewController: UIViewController, AVAudioRecorderDelegate {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    @IBOutlet weak var gravarBotao: UIButton!
    var audioFileName: URL!
    var result: String = ""
    var downloadReference: URL!
    
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
    
    func pegarDataAtual() {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm:ssdd-MM-yyyy"
        
        result = formatter.string(from: date)
       
    }
    
    // MARK: Firestore
    
    @IBAction func apertouSalvar(_ sender: Any) {
        pegarDataAtual()
        // Onde tá o arquivo localmente, em String em vez de URL
        //Referência ao Storage
        let fileId = self.result + ".m4a"
        let storage = Storage.storage()
        
        //Referência ao Storage
        let storageRef = storage.reference()
        
        //Referência ao arquivo que eu vou fazer o upload
        let archiveRef = storageRef.child(fileId)
        
        let uploadTask = archiveRef.putFile(from: audioFileName, metadata: nil) { metadata, error in
            if let error = error {
                print("deu ruim de novo na metadata", error)
                return
            } else {
                        // MARK: Salvar no Firebase a nova mensagem
                        var novaMensagem = Mensagem(audio: fileId, datadeEnvio: self.result, de: 00001, idMensagem: self.result, para: 00002, salvo: false, visualizado: false)
                        DAOFirebase.save(mensagem: novaMensagem)
            }
           
           
        }
            
           
            print("acho que deu boa")
    }

    
}
