//
//  ViewController.swift
//  iQuiz
//
//  Created by iguest on 2/17/26.
//

import UIKit

struct Quiz {
    let topic: String
    let description: String
    let icon: UIImage
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let quizzes = [
        Quiz(
            topic: "Mathematics",
            description: "Test your math skills.",
            icon: UIImage(systemName: "function")!
        ),
        Quiz(
            topic: "Marvel Super Heroes",
            description: "How well do you know your Marvel super heroes?",
            icon: UIImage(systemName: "bolt.fill")!
        ),
        Quiz(
            topic: "Science",
            description: "Test your science knowledge.",
            icon: UIImage(systemName: "atom")!
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
        let quiz = quizzes[indexPath.section]

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
    
    // row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // section header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    // section header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
        
    @IBAction func showSettings(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

