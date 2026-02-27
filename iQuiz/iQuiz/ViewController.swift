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
    
    var quizData: [Quiz] = []
    var selectedQuiz: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        let url = UserDefaults.standard.string(forKey: "quiz_url") ??
        "http://tednewardsandbox.site44.com/questions.json"
        GetQuiz.shared.fetchQuizzes(url) { quizzes, networkAvailable in
            DispatchQueue.main.async {
            self.quizData = quizzes
            self.tableView.reloadData()
                if networkAvailable == false {
                    self.showNetworkError()
                }
            }
        }
    }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return quizData.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
            let quiz = quizData[indexPath.section]
            
            cell.textLabel?.text = quiz.title
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            
            cell.detailTextLabel?.text = quiz.desc
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            
            cell.imageView?.image = UIImage(systemName: "questionmark.circle")
            
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
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }

        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestion",
           let destination = segue.destination as? QuestionViewController,
           let index = selectedQuiz {
            destination.quiz = quizData[index]
        }
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Network Error",
            message: "Network is unavailable. Please check your connection.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        present(alert, animated: true)
    }
    
    @objc func refresh() {
        let url = UserDefaults.standard.string(forKey: "quiz_url") ??
        "http://tednewardsandbox.site44.com/questions.json"
        
        GetQuiz.shared.fetchQuizzes(url) { quizzes, networkAvailable in
            DispatchQueue.main.async {
                self.quizData = quizzes
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                
                if networkAvailable == false {
                    self.showNetworkError()
                }
            }
        }
    }
}

