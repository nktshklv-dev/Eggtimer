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
    
    let urlTimer = Bundle.main.url(forResource: "CLOCKTick_Tic tac mechanical alarm clock 2 (ID 2655)_BSB", withExtension: "wav")!
    let urlDing = Bundle.main.url(forResource: "microwave-timer-bright-design-microwave-oven-ping-timer-117077", withExtension: "mp3")!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var headerLabel: UILabel!
    var player: AVAudioPlayer?
    var remainedTime = 0
    let eggTimes: [String : Int] = ["Soft" : 30, "Medium" : 480, "Hard" : 720 ]
    var timer:  Timer?
    var timePassed = 0{
        
            didSet{
                headerLabel.text = "Cooking..."
            }
        }
    
        
    @IBAction func hardnessSelected(_ sender: UIButton) {
       
        player = try? AVAudioPlayer(contentsOf: urlTimer)
        
        
        timer?.invalidate()
        timePassed = 0
        let hardness = sender.currentTitle!
        remainedTime = eggTimes[hardness]!
        print(remainedTime)
       timer = Timer.scheduledTimer(timeInterval: 1.0 , target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
         
        
    }
    
    
    @objc func updateCounter(){
        if timePassed <= remainedTime{
            
            let percentageProgress = Float(timePassed) / Float(remainedTime)
            progressView.progress = percentageProgress
            headerLabel.text = "\(remainedTime) seconds remained."
            print("\(timePassed) seconds.")
            timePassed += 1
            player?.play()
            
        }
        else {
            timer?.invalidate()
            headerLabel.text = "DONE!"
            player?.stop()
            player = try? AVAudioPlayer(contentsOf: urlDing)
            player?.play()
        }
    }
    
}
