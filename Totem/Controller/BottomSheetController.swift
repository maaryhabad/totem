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
    case initial
    case recording
    case stopped
}

class BottomSheetController: UIViewController {
    @IBOutlet var record: UIView!
    @IBOutlet var recordButton: UIImageView!
    
    @IBOutlet weak var recordHeight: NSLayoutConstraint!
    @IBOutlet weak var audioInputPlot: EZAudioPlot!
    @IBOutlet var audioLabelView: UIView!
    @IBOutlet var audioLabel: UILabel!
    
    let mic = AKMicrophone()
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    
    var running: state = .initial
    override func viewDidLoad() {
        super.viewDidLoad()
        
        record.layer.cornerRadius = 25
        
        recordButton.image = UIImage(named: "BtnGravar")
        
        tracker = AKFrequencyTracker.init(mic)
        silence = AKBooster(tracker, gain: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AudioKit.output = silence
        setupPlot()
    }
    
    @IBAction func recordButtonTap(_ sender: Any) {
        if (running == .initial) {
            recordButton.image = UIImage(named: "BtnStop")
            self.view.layoutIfNeeded()
            self.recordHeight.constant = 250
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()

                do {
                    try AudioKit.start()
                } catch {
                    print("Erro!")
                }
            })
            running = .recording
        } else if (running == .recording) {
            recordButton.image = UIImage(named: "BtnEnviar")
            audioInputPlot.isHidden = true
            audioLabelView.isHidden = false
            
            do {
                try AudioKit.stop()
            } catch {
                print("Erro!")
            }
            running = .stopped
        }
    }
    
    func setupPlot() {
        let plot = AKNodeOutputPlot(mic, frame: audioInputPlot.bounds)
        plot.plotType = .rolling
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.color = .white
        plot.backgroundColor = .clear
        audioInputPlot.addSubview(plot)
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
