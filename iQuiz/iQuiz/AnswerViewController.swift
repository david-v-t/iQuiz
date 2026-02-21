//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by iguest on 2/19/26.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var quiz: Quiz!
    var selectedAnswer: Int!
    var currentQuestionIndex: Int = 0
    var correctAnswers: Int = 0
    
    var question: Question {
        return quiz.questions[currentQuestionIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        let backArrow = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backToFront)
        )
        navigationItem.leftBarButtonItem = backArrow
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(backToFront))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        showResult()
    }
    
    func showResult() {
        questionLabel.text = question.text
        
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
        for (index, button) in buttons.enumerated() {
            if index < question.answers.count {
                button?.setTitle(question.answers[index], for: .normal)
                button?.isEnabled = false
                button?.backgroundColor = .systemGray5
                button?.setTitleColor(.black, for: .normal)
            } else {
                button?.isHidden = true
            }
        }
        
        if selectedAnswer == question.correctAnswerIndex {
            buttons[selectedAnswer]?.backgroundColor = .systemGreen
            resultLabel.text = "Correct!"
            correctAnswers += 1
        } else {
            buttons[selectedAnswer]?.backgroundColor = .systemRed
            resultLabel.text = "Incorrect"
        }
        
        resultLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
         let nextIndex = currentQuestionIndex + 1
        
         if nextIndex < quiz.questions.count {
             performSegue(withIdentifier: "showQuestion", sender: nextIndex)
         } else {
             performSegue(withIdentifier: "showFinished", sender: nil)
         }
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestion" {
            if let nextIndex = sender as? Int,
               let destination = segue.destination as? QuestionViewController {
                destination.quiz = quiz
                destination.currentQuestionIndex = nextIndex
                destination.correctAnswers = correctAnswers
            }
            
        } else if segue.identifier == "showFinished" {
            if let destination = segue.destination as? FinishedViewController {
                destination.correctAnswers = correctAnswers
                destination.numQuestions = quiz.questions.count
            }
        }
    }
    
    @objc func backToFront() {
        navigationController?.popToRootViewController(animated: true)
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
