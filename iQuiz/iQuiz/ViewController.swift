//
//  ViewController.swift
//  iQuiz
//
//  Created by iguest on 2/17/26.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let quizData = QuizData()
    var selectedQuiz: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizData.quizzes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
        let quiz = quizData.quizzes[indexPath.section]

        cell.textLabel?.text = quiz.topic
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.detailTextLabel?.text = quiz.description
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping

        cell.imageView?.image = quiz.icon
        
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQuiz = indexPath.section
        performSegue(withIdentifier: "showQuestion", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    @IBAction func showSettings(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestion",
           let destination = segue.destination as? QuestionViewController,
           let index = tableView.indexPathForSelectedRow {
            let selectedQuiz = QuizData().quizzes[index.section]
            destination.quiz = selectedQuiz
        }
    }
}

