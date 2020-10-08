//
//  ViewController.swift
//  Catch the Agraelus!
//
//  Created by Jakub Jirák on 06/10/2020.
//  Copyright © 2020 JakubJirak. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let generator = UINotificationFeedbackGenerator()
    var player: AVAudioPlayer?
    var emotePlayer: AVAudioPlayer?
    var score = 0
    var highScore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var agraelusArray = [UIImageView()]

    func playSound(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {
            print("Tone for "+soundName+" not found!")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            emotePlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let emotePlayer = emotePlayer else { return }

            emotePlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    //Views
    @IBOutlet var gamePane: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var agraelus1: UIImageView!
    @IBOutlet weak var agraelus2: UIImageView!
    @IBOutlet weak var agraelus3: UIImageView!
    @IBOutlet weak var agraelus4: UIImageView!
    @IBOutlet weak var agraelus5: UIImageView!
    @IBOutlet weak var agraelus6: UIImageView!
    @IBOutlet weak var agraelus7: UIImageView!
    @IBOutlet weak var agraelus8: UIImageView!
    @IBOutlet weak var agraelus9: UIImageView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        playTheme()
        scoreLabel.text = "Score: \(score)"

        let storedHighScore = UserDefaults.standard.object(forKey: "catchTheAgraelusHighScore")
        if(storedHighScore == nil){
            highScore = 0
            highscoreLabel.text = "High score: \(highScore)"
        }

        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "High score: \(highScore)"
        }

        gamePane.isUserInteractionEnabled = true
        agraelus1.isUserInteractionEnabled = true
        agraelus2.isUserInteractionEnabled = true
        agraelus3.isUserInteractionEnabled = true
        agraelus4.isUserInteractionEnabled = true
        agraelus5.isUserInteractionEnabled = true
        agraelus6.isUserInteractionEnabled = true
        agraelus7.isUserInteractionEnabled = true
        agraelus8.isUserInteractionEnabled = true
        agraelus9.isUserInteractionEnabled = true

        let recognizer0 = UITapGestureRecognizer(target: self, action:#selector(decreaseScore))
        let recognizer1 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action:#selector(increaseScore))

        gamePane.addGestureRecognizer(recognizer0)
        agraelus1.addGestureRecognizer(recognizer1)
        agraelus2.addGestureRecognizer(recognizer2)
        agraelus3.addGestureRecognizer(recognizer3)
        agraelus4.addGestureRecognizer(recognizer4)
        agraelus5.addGestureRecognizer(recognizer5)
        agraelus6.addGestureRecognizer(recognizer6)
        agraelus7.addGestureRecognizer(recognizer7)
        agraelus8.addGestureRecognizer(recognizer8)
        agraelus9.addGestureRecognizer(recognizer9)

        agraelusArray = [agraelus1,agraelus2,agraelus3,agraelus4,agraelus5,agraelus6,agraelus7,agraelus8,agraelus9]

        counter = 30
        timeLabel.text = String(counter)

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideAgrael), userInfo: nil, repeats: true)

        hideAgrael()
    }

    @objc func decreaseScore(){
        generator.notificationOccurred(.error)
        if(score>1){
            score -= 1
        }
        scoreLabel.text = "Score: \(score)"
        playSound(soundName: "nope")
        hideAgrael()
    }

    @objc func increaseScore(){
        generator.notificationOccurred(.success)

        score += 1
        scoreLabel.text = "Score: \(score)"
        playSound(soundName: "doh")
        hideAgrael()
    }

    @objc func playTheme(){
        let soundName = "CatchTheAgraelTheme"
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {
            print("Tone for "+soundName+" not found!")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }


    @objc func hideAgrael(){
        for agraelus in agraelusArray {
            agraelus.isHidden = true
        }

        let random = Int.random(in: 0..<agraelusArray.count)
        agraelusArray[random].isHidden = false
    }

    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)

        if(counter==0){
            timer.invalidate()
            hideTimer.invalidate()

            //Alert
            let alert = UIAlertController(title: "Čas vypršel", message: "Chceš si zahrát znovu?\nTvoje skóre bylo: \(score)", preferredStyle: UIAlertController.Style.alert)

            let replayButton = UIAlertAction(title: "Nová hra", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                //replay function
                if(self.score > self.highScore){
                    self.highScore = self.score
                    self.highscoreLabel.text = "Highscore: \(self.highScore)"
                }
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = String(self.counter)

                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideAgrael), userInfo: nil, repeats: true)
                self.playTheme()
            }
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

}
