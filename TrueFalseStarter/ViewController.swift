//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // Buttons & Labelsv
    @IBOutlet weak var questionArea: UILabel!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var resultArea: UILabel!

    // The variables 
    var questionPerRound = 4
    var questionsAsked = 0
    var score = 0
    var gameSound: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game 
        primeTheApp()
        playGameStartSound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Set up the welcome screen 
    func primeTheApp() {
        answerButtonOne.isHidden = true
        answerButtonTwo.isHidden = true
        answerButtonThree.isHidden = true
        answerButtonFour.isHidden = true
        resultArea.isHidden = true
        questionArea.text = "Are You ready to quiz?"
        generateRoundQuestions()
}
    // Starts round and asks question form the generated index 
    @IBAction func startRound() {
        
        nextQuestion()
        
        questionArea.text = newQuestions[questionIndex].questions
        answerButtonOne.setTitle(newQuestions[questionIndex].answer[1], for: UIControlState.normal)
        answerButtonTwo.setTitle(newQuestions[questionIndex].answer[2], for: UIControlState.normal)
        answerButtonThree.setTitle(newQuestions[questionIndex].answer[3], for: UIControlState.normal)
        answerButtonFour.setTitle(newQuestions[questionIndex].answer[4], for: UIControlState.normal)
        
        answerButtonOne.isHidden = false
        answerButtonTwo.isHidden = false
        answerButtonThree.isHidden = false
        answerButtonFour.isHidden = false
        playAgainButton.isHidden = true
        resultArea.isHidden = true
        
        answerButtonOne.alpha = 1
        answerButtonTwo.alpha = 1
        answerButtonThree.alpha = 1
        answerButtonFour.alpha = 1
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
            questionsAsked += 1
            print(questionsAsked)
        
        let answer = newQuestions[questionIndex].correctAnswer
        
        if (sender == answerButtonOne && answer == 1) || (sender == answerButtonTwo && answer == 2) || (sender == answerButtonThree && answer == 3) || (sender == answerButtonFour && answer == 4) {
            
            resultArea.text = "Yes \(newQuestions[questionIndex].answer[answer]!) is correct"
            score += 1
        }
            
        else {
            resultArea.text = "No sorry it was \(newQuestions[questionIndex].answer[answer]!)."
        }
        
        // Dimming incorrect answers 
        if newQuestions[questionIndex].correctAnswer == 1 {
            answerButtonTwo.alpha = 0.3
            answerButtonThree.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if newQuestions[questionIndex].correctAnswer == 2 {
            answerButtonOne.alpha = 0.3
            answerButtonThree.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if newQuestions[questionIndex].correctAnswer == 3 {
            answerButtonOne.alpha = 0.3
            answerButtonTwo.alpha = 0.3
            answerButtonFour.alpha = 0.3
        } else if newQuestions[questionIndex].correctAnswer == 4 {
            answerButtonOne.alpha = 0.3
            answerButtonTwo.alpha = 0.3
            answerButtonThree.alpha = 0.3
        }
        
        resultArea.isHidden = false
        
        addDelay()
        
    }
    
    // Delayed transition between questions
    func loadNextRound() {
        
        if questionsAsked == 4 {
            displayScore()
        } else {
            startRound()
        }
    }
    
    func addDelay () {
        let time = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.loadNextRound()
        }
    }
    
    // Display final score 
    func displayScore() {
        
        switch score {
        case 0:
            questionArea.text = "\(score)? That's pretty damn bad."
        case 1: questionArea.text = "Well, \(score) means you could have technically done worse..."
        case 2: questionArea.text = "Ok. \(score) is respectable. I guess."
        case 3: questionArea.text = "Woah. \(score) you are strating to get the hang of it."
        case 4: questionArea.text = "Woah. \(score) now thats what im talking about."
        default: break
        }
        
        questionIndex = roundQuestions.remove(at: GKRandomSource.sharedRandom().nextInt(upperBound: roundQuestions.count))
        generateRoundQuestions()
        
        answerButtonOne.isHidden = true
        answerButtonTwo.isHidden = true
        answerButtonThree.isHidden = true
        answerButtonFour.isHidden = true
        resultArea.isHidden = true
        playAgainButton.isHidden = false
        
        playAgainButton.setTitle("Again?", for: UIControlState.normal)
        
        score = 0
        questionsAsked = 0
    }
    
    // Loading sound effects
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

