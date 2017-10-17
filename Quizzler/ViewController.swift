//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var currentQuestion : Int = 0
    var pickedAnswer : Bool = false
    var userScore : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else {
            pickedAnswer = false
        }
        
        checkAnswer()
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
        questionLabel.text = allQuestions.list[currentQuestion].questionText
        scoreLabel.text = "\(userScore)"
        progressLabel.text = "\(currentQuestion + 1)/13"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(currentQuestion + 1)
    }

    func nextQuestion() {
        if currentQuestion == allQuestions.list.count - 1 {
            currentQuestion += 1
        }
        else {
            endQuizzler()
        }
    }
    
    func endQuizzler() {
        let endingMessage : String = "You got to the end of the Quiz! You scored \(userScore). Do you want to start again?"
        let alert = UIAlertController(title: "You finished it!", message: endingMessage, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
            self.startOver()
        })
        
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
    
    func checkAnswer() {
        if pickedAnswer == allQuestions.list[currentQuestion].answer {
            userScore += 10
            ProgressHUD.showSuccess("Correct!")
    }
        else {
            userScore -= 1
            ProgressHUD.showError("Wrong!")
        }
    }
    
    func startOver() {
        userScore = 0
        currentQuestion = 0
        updateUI()
    }
    

    
}
