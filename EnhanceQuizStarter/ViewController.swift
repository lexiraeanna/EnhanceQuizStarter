//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    

    // MARK: - Properties
    var gameSound: SystemSoundID = 0
    var gameManager = GameManager(questionsPerRound: 4)
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var Option1: UIButton!
    @IBOutlet weak var Option2: UIButton!
    @IBOutlet weak var Option3: UIButton!
    @IBOutlet weak var Option4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        playGameStartSound()
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    

    func displayQuestion() {
       let randomNumber = gameManager.checkNumber()
        let questionDisplay = gameManager.trivia[randomNumber]
        questionField.text = questionDisplay.question
    
        Option1.setTitle(questionDisplay.options[0], for: UIControl.State.normal)
        Option2.setTitle(questionDisplay.options[1], for: UIControl.State.normal)
        if (questionDisplay.options.count <= 2) {
            Option3.isHidden = true
            Option4.isHidden = true
        } else {
            Option3.isHidden = false
            Option3.setTitle(questionDisplay.options[2], for: UIControl.State.normal)
            if (questionDisplay.options.count == 4) {
                Option4.isHidden = false
                Option4.setTitle(questionDisplay.options[3], for: UIControl.State.normal)
            }
        }

        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        Option1.isHidden = true
        Option2.isHidden = true
        Option3.isHidden = true
        Option4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(gameManager.correctQuestions) out of \(gameManager.questionsPerRound) correct!"
    }
    
    func nextRound() {
        if gameManager.questionsAsked == gameManager.questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
       gameManager.questionsAsked += 1
        
        let selectedQuestionDict = gameManager.trivia[gameManager.indexOfSelectedQuestion]
        if (sender === Option1 &&  selectedQuestionDict.answer == selectedQuestionDict.options[0]) || (sender === Option2 &&  selectedQuestionDict.answer == selectedQuestionDict.options[1]) || (sender === Option3 &&  selectedQuestionDict.answer == selectedQuestionDict.options[2]) || (sender === Option4 &&  selectedQuestionDict.answer == selectedQuestionDict.options[3]){
            gameManager.correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRound(delay: 1)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        Option1.isHidden = false
        Option2.isHidden = false
        Option3.isHidden = false
        Option4.isHidden = false
    
        
        gameManager.questionsAsked = 0
        gameManager.correctQuestions = 0
        nextRound()
    }
    
    
}

