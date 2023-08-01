//
//  ViewController.swift
//  EggTimer
//
//  Created by Мявкo on 1.08.23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft": 300, "Medium": 480, "Hard": 720]
    
    var player: AVAudioPlayer!
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        secondsPassed = 0
        titleLabel.text = hardness
 
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secondsPassed <= totalTime {
            
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1
        } else {
            playSound()
            timer.invalidate()
            titleLabel.text = "DONE!"
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "egg-timer", withExtension: "m4a")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

