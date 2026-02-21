//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by iguest on 2/19/26.
//

import UIKit

class FinishedViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var correctAnswers: Int = 0
    var numQuestions: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let percent = Double(correctAnswers) / Double(numQuestions)
        
        if percent == 1.0 {
            descriptionLabel.text = "Perfect!"
        } else if percent >= 0.67 {
            descriptionLabel.text = "Almost!"
        } else {
            descriptionLabel.text = "Try again!"
        }
        
        scoreLabel.text = "\(correctAnswers) of \(numQuestions) correct"
        scoreLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 24)
        doneButton.backgroundColor = .systemBlue
        
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
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
