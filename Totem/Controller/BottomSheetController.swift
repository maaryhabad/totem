//
//  BottomSheetController.swift
//  totem
//
//  Created by Kevin Katzer on 01/11/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

enum state {
    case ready
    case recording
    case recorded
}

class BottomSheetController: UIViewController {
    @IBOutlet var record: UIView!
    @IBOutlet var recordButton: UIImageView!
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerSlider: UISlider!
    @IBOutlet weak var currentPlayerTime: UILabel!
    @IBOutlet weak var totalPlayerTime: UILabel!
    @IBOutlet weak var playButton: UIImageView!
    @IBOutlet weak var goBackward: UIImageView!
    @IBOutlet weak var goForward: UIImageView!
    
    @IBOutlet weak var recordHeight: NSLayoutConstraint!
    @IBOutlet weak var audioInputPlot: UIView!
    @IBOutlet var audioLabelView: UIView!
    @IBOutlet var audioLabel: UILabel!
    var displayLink: CADisplayLink! = nil
    
    var micMixer: AKMixer!
    var recorder: AKNodeRecorder!
    var player: AKAudioPlayer!
    var tape: AKAudioFile!
    var micBooster: AKBooster!
    var mainMixer: AKMixer!
    var plot: AKNodeOutputPlot?

    let mic = AKMicrophone()
    
    var running: state = .ready
    var skippedTo: Double = 0.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        AKAudioFile.cleanTempDirectory()
        
        AKSettings.bufferLength = .medium
        
        do {
            try AKSettings.setSession(category: .playAndRecord, with: .allowBluetoothA2DP)
        } catch {
            AKLog("Could not set session category.")
        }

        AKSettings.defaultToSpeaker = true
        
        let monoToStereo = AKStereoFieldLimiter(mic, amount: 1)
        micMixer = AKMixer(monoToStereo)
        micBooster = AKBooster(micMixer)

        // Will set the level of microphone monitoring
        micBooster.gain = 0
        recorder = try? AKNodeRecorder(node: micMixer)
        if let file = recorder.audioFile {
            do {
                try player = AKAudioPlayer(file: file)
            } catch {
                AKLog("Error on file loading")
            }
        }
        player.looping = false
        player.completionHandler = onPlayFinish

        mainMixer = AKMixer(player, micBooster)

        AudioKit.output = mainMixer
        do {
            try AudioKit.start()
        } catch {
            AKLog("AudioKit did not start!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        record.layer.cornerRadius = 25
        
        recordButton.image = UIImage(named: "BtnGravar")
        
        playerSlider.isContinuous = false
        
        setupPlot()
        
        let config = UIImage.SymbolConfiguration(scale: .small)
        let thumb = UIImage(systemName: "circle.fill")?.withConfiguration(config).withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        playerSlider.setThumbImage(thumb, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func recordButtonTap(_ sender: Any) {
        if (running == .ready) {
            recordButton.image = UIImage(named: "BtnStop")
            self.view.layoutIfNeeded()
            self.recordHeight.constant = 250
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
            if AKSettings.headPhonesPlugged {
                micBooster.gain = 1
            }
            micMixer.outputNode.removeTap(onBus: 0)
            do {
                try recorder.record()
            } catch { AKLog("Errored recording.") }
            running = .recording
            audioInputPlot.isHidden = false
        } else if (running == .recording) {
            recordButton.image = UIImage(named: "BtnEnviar")
            audioInputPlot.isHidden = true
            audioLabelView.isHidden = false
            
            micBooster.gain = 0
            tape = recorder.audioFile!
            do {
                try player.replace(file: tape)
            } catch {
                AKLog("Error on audio loading")
            }
            
            let duration = player.audioFile.duration
            recorder.stop()
            audioLabel.text = String(Int(duration/60)) + ":" + String(format: "%02d", Int(duration.truncatingRemainder(dividingBy: 60)))
            tape.exportAsynchronously(name: "tmp.wav", baseDir: .documents, exportFormat: .wav) {_, exportError in
                if let error = exportError {
                    AKLog("Export Failed \(error)")
                } else {
                    AKLog("Export succeeded")
                }
            }
            running = .recorded
        } else if (running == .recorded) {
            let duration = player.audioFile.duration
            totalPlayerTime.text = String(Int(duration/60)) + ":" + String(format: "%02d", Int(duration.truncatingRemainder(dividingBy: 60)))
            playerView.isHidden = false
        }
    }
    
    @IBAction func playAudio(_ sender: Any) {
        var playing = false
        if player != nil {
            playing = player.isPlaying
        } else {
            AKLog("Error")
        }
        
        if !playing {
            player.play(from: 0.0)
            skippedTo = 0.0
            
            if (displayLink == nil) {
                displayLink = CADisplayLink(target: self, selector: #selector(updateSliderProgress))
                displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
            }
            
            playButton.image = UIImage(systemName: "pause.fill")
        } else {
            player.pause()
            playButton.image = UIImage(systemName: "play.fill")
        }
    }
    
    @objc func updateSliderProgress() {
        let time = player.currentTime + skippedTo
        let progress = time / player.duration
        playerSlider.setValue(Float(progress), animated: false)
        currentPlayerTime.text = String(Int(time/60)) + ":" + String(format: "%02d", Int(time.truncatingRemainder(dividingBy: 60)))
    }
    
    func onPlayFinish() {
        player.stop()
        if (displayLink != nil) {
            displayLink.invalidate()
            displayLink = nil
        }
        playButton.image = UIImage(systemName: "play.fill")
    }
    
    @IBAction func touchDownSlider(_ sender: UISlider) {
        if (displayLink != nil) {
            displayLink.invalidate()
            displayLink = nil
        }
    }
    
    
    @IBAction func sliderChange(_ sender: UISlider) {
        let currentValue = Double(sender.value)
        playButton.image = UIImage(systemName: "pause.fill")
        skippedTo = player.duration * currentValue
        player.stop()
        if (displayLink == nil) {
            displayLink = CADisplayLink(target: self, selector: #selector(updateSliderProgress))
            displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
        }
        DispatchQueue.global().async {
            self.player.play(from: self.skippedTo)
        }
    }
    
    @IBAction func backward(_ sender: Any) {
        playButton.image = UIImage(systemName: "pause.fill")
        let current = player.currentTime + skippedTo
        skippedTo = current < 15 ? 0.0 : current - 15
        print(skippedTo)
        player.stop()
        if (displayLink == nil) {
            displayLink = CADisplayLink(target: self, selector: #selector(updateSliderProgress))
            displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
        }
        DispatchQueue.global().async {
            self.player.play(from: self.skippedTo)
        }
    }
    
    @IBAction func forward(_ sender: Any) {
        playButton.image = UIImage(systemName: "pause.fill")
        let current = player.currentTime + skippedTo
        skippedTo = current > player.duration - 15 ? player.duration : current + 15
        print(skippedTo)
        player.stop()
        if (displayLink == nil) {
            displayLink = CADisplayLink(target: self, selector: #selector(updateSliderProgress))
            displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
        }
        DispatchQueue.global().async {
            self.player.play(from: self.skippedTo)
        }
    }
    
    func setupPlot() {
        plot = AKNodeOutputPlot(mic, frame: audioInputPlot.bounds)
        plot?.plotType = .buffer
        plot?.shouldFill = true
        plot?.shouldMirror = true
        plot?.color = .white
        plot?.backgroundColor = .clear
        audioInputPlot.addSubview(plot!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
