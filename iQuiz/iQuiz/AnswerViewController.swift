//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by iguest on 2/19/26.
//

import UIKit

class AnswerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false

        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return question.answers.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
        let answerIndex = indexPath.section
        cell.textLabel?.text = question.answers[answerIndex]
        
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4

        if answerIndex == question.correctAnswerIndex {
            cell.backgroundColor = .systemGreen
        } else if answerIndex == selectedAnswer {
            cell.backgroundColor = .systemRed
        }

        return cell
    }
    
    func showResult() {
        questionLabel.text = question.text

        if selectedAnswer == question.correctAnswerIndex {
            resultLabel.text = "Correct!"
            resultLabel.textColor = .systemGreen
            correctAnswers += 1
        } else {
            resultLabel.text = "Incorrect"
            resultLabel.textColor = .systemRed
        }

        resultLabel.font = UIFont.boldSystemFont(ofSize: 24)
        tableView.reloadData()
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
