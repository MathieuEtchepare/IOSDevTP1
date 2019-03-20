//
//  ViewController.swift
//  Hangman_works
//
//  Created by Kilian POULIN on 27/02/2019.
//  Copyright © 2019 Efreeeeey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var WordLabel: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var WinCountLabel: UILabel!
    @IBOutlet weak var FailCountLabel: UILabel!
    
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    
    @IBOutlet weak var Hangman: UIImageView!
    
    @IBOutlet var KeyBoard: [UIButton]!
    
    var game = Hangman()
    
    var runCount = 5
    var WinCount = 0
    var FailCount = 0
    var stop = false
    var correct_word = ""
    var hangman = 0
    let dictionary = 
    
    @IBAction func enter_key(_ sender: UIButton) {
        checkAnswer(on: sender)
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        sender.isEnabled = false
        StopButton.isEnabled = true
        startingGame()
        for var s in KeyBoard{
            s.isEnabled = true
        }
        
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
            self.runCount -= 1
            self.TimerLabel.text = String(self.runCount)
            
            if self.runCount == 0 {
                timer.invalidate()
                self.pop_up(title: "YOU LOSE!", message: "Time's up! The correct answer was " + self.correct_word)
                self.disableEverything()
                self.FailCount += 1
                self.FailCountLabel.text = String(self.FailCount)
            }
            else if self.stop == true {
                timer.invalidate()
            }
        }
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        sender.isEnabled = false
        StartButton.isEnabled = true
        stop = true
        disableEverything()
    }
    
    func disableEverything(){
        for var s in KeyBoard{    //    disables keyboard
            s.isEnabled = false
        }
        stop = true             //  flag to stop the timer
        StopButton.isEnabled = false
        StartButton.isEnabled = true
    }
    
    func startingGame(){
        hangman = 0
        stop = false
        correct_word = dictionary[Int.random(in:0..<dictionary.count)]
        TimerLabel.text = "5"
        runCount = 5
        let cpt_word = correct_word.count
        
        var tirets = ""
        for _ in 1...cpt_word{
            tirets += "_ "
        }
        
        for var s in KeyBoard{
            s.isEnabled = false
        }
        
        Hangman.image = UIImage(named: "Hangman-0.jpg")
        WordLabel.text = tirets
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimerLabel.text = "5"
        WinCountLabel.text = "0"
        FailCountLabel.text = "0"
        WordLabel.text = "PRESS START"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func pop_up(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func Check_win(){
        
        if(WordLabel.text!.contains("_") == false){
            pop_up(title: "CONGRATS!", message: "YOU WIN!")
            disableEverything()
            WinCount += 1
            WinCountLabel.text = String(WinCount)
        }
        else if(hangman == 6){
            pop_up(title: "YOU LOSE!", message: "The correct answer was " + correct_word)
            disableEverything()
            FailCount += 1
            FailCountLabel.text = String(FailCount)
        }
    }
    
    func checkAnswer(on button: UIButton){
        button.isEnabled = false
        if(correct_word.contains(button.currentTitle!)){
            runCount = 5
            TimerLabel.text = "5"
            var nb = 0
            let charTab = Array(correct_word)
            for var chara in charTab{
                if(chara == Array(button.currentTitle!)[0]){
                    var striing = Array((WordLabel.text)!)
                    striing[nb*2] = chara
                    WordLabel.text = String(striing)
                }
                nb += 1
                
                
            }
        } else {
            hangman += 1
            Hangman.image = UIImage(named: "Hangman-" + String(hangman) + ".jpg")
        }
        Check_win()
        
    }
    
}

