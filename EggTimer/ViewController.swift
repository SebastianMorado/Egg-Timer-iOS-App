//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer:Timer?
    var timeLeft:Int = 0
    var timeMax:Int?
    var player: AVAudioPlayer!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        //Change UI to reflect time left
        progressBar.progress = 1 - (Float(timeLeft) / Float(timeMax!))
        
        //Timer is done
        //Play alarm sound and change label
        if timeLeft <= 0 {
            timeLabel.text = "Done!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            timer?.invalidate()
            timer = nil
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //Remove any previous timers
        timer?.invalidate()
        timer = nil
        progressBar.progress = 0
        //Start a timer
        timeLabel.text = sender.currentTitle!
        timeLeft = eggTimes[sender.currentTitle!]! + 1
        timeMax = timeLeft
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
    }
    
    

}
