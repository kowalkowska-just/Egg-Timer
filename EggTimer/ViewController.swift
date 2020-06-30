//
//  ViewController.swift
//  EggTimer
//
//  Created by Justyna Kowalkowska on 30/06/2020.
//  Copyright © 2020 Justyna Kowalkowska. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    var eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    
    var secondsRemaining = 60
    var timeEgg: Int = 0
    var timer = Timer()
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var proressView: UIProgressView!
    
    
    @IBAction func hardnessSelection(_ sender: UIButton) {
        
        proressView.progress = 0.0
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        
        textLabel.text = hardness
        
        secondsRemaining = eggTimes[hardness]!
        timeEgg = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func PlaySound(soundName: String){
        let mp3 = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: mp3!)
        player.play()
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            var procent: Float
            var progress: Float
            
            procent = Float(secondsRemaining) / Float(timeEgg)
            progress = 1 - procent
            proressView.progress = progress
            
            print("\(secondsRemaining) seconds.")
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            textLabel.text = "Done!"
            proressView.progress = 1.0
            PlaySound(soundName: "alarm_sound")
            }
        }
    

}

