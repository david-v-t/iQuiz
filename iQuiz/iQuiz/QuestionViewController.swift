//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iguest on 2/19/26.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var quiz: Quiz!
    var selectedAnswer: Int? = nil
    var currentQuestionIndex: Int = 0
    var correctAnswers: Int = 0
    
    var question: Question {
        return quiz.questions[currentQuestionIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(backToFront)
        )
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(backToFront))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        showQuestionAndAnswers()
    }
    
    func showQuestionAndAnswers() {
        questionLabel.text = question.text
        selectedAnswer = nil
        
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
        for (index, button) in buttons.enumerated() {
            if index < question.answers.count {
                button?.setTitle(question.answers[index], for: .normal)
                button?.isHidden = false
                button?.isEnabled = true
                button?.tag = index
            } else {
                button?.isHidden = true
            }
        }
        
        submitButton.isEnabled = false
        submitButton.backgroundColor = .systemGray2
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        selectedAnswer = sender.tag
        
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
        
        for button in buttons {
            button?.backgroundColor = .systemGray5
            button?.setTitleColor(.black, for: .normal)
        }
        
        sender.backgroundColor = .systemTeal
        sender.setTitleColor(.white, for: .normal)

        submitButton.isEnabled = true
        submitButton.backgroundColor = .systemBlue
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        performSegue(withIdentifier:"showAnswers", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnswers" {
            let destination = segue.destination as! AnswerViewController
            destination.quiz = quiz
            destination.currentQuestionIndex = currentQuestionIndex
            destination.selectedAnswer = selectedAnswer
            destination.correctAnswers = correctAnswers
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
