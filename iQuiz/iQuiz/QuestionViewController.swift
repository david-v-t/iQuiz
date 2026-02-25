//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iguest on 2/19/26.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        
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
        
        questionLabel.text = question.text
        
        submitButton.isEnabled = false
        submitButton.backgroundColor = .systemGray2
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
        cell.textLabel?.text = question.answers[indexPath.section]
        
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4
        
        
        return cell
    }
    
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnswer = indexPath.section
        tableView.reloadData()
        for cell in tableView.visibleCells {
            cell.backgroundColor = .white
            cell.textLabel?.textColor = .black
        }
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .systemTeal
        cell?.textLabel?.textColor = .white
    
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
