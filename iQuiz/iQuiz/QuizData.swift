//
//  QuizData.swift
//  iQuiz
//
//  Created by iguest on 2/19/26.
//

import Foundation
import UIKit

struct Quiz {
    let topic: String
    let description: String
    let icon: UIImage
    let questions: [Question]
}

struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}

struct QuizData {
    
    let quizzes: [Quiz] = [
        
        Quiz(
            topic: "Mathematics",
            description: "Test your math skills.",
            icon: UIImage(systemName: "function")!,
                questions: [
                Question(
                    text: "What is 6 + 4?",
                    answers: ["10", "8", "12", "9"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What is 9 * 12",
                    answers: ["102", "118", "111", "108"],
                    correctAnswerIndex: 3
                ),
                Question(
                    text: "What is 49 / 7?",
                    answers: ["7", "6", "5", "8"],
                    correctAnswerIndex: 0
                )
            ]
        ),
        Quiz(
            topic: "Marvel Super Heroes",
            description: "How well do you know your Marvel super heroes?",
            icon: UIImage(systemName: "bolt.fill")!,
            questions: [
                Question(
                    text: "What super hero got bit by a radioactive spider?",
                    answers: ["Spider-Man", "Venom", "Peter Porker", "Spider-Girl"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "Batman is a Marvel superhero.",
                    answers: ["True", "False"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What is the name of Thor's hammer?",
                    answers: ["Stormbringer", "Infinity Hammer", "Mjolnir"],
                    correctAnswerIndex: 2
                )
            ]
        ),
        Quiz(
            topic: "Science",
            description: "Test your science knowledge.",
            icon: UIImage(systemName: "atom")!,
            questions: [
                Question(
                    text: "What is the process called when plants convert light energy into food?",
                    answers: ["Photosynthesis", "Chlorophyll production", "Cellular Respiration", "Mitochondria"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What is the chemical formula for salt?",
                    answers: ["HCI", "SaLt", "H2O", "NaCl"],
                    correctAnswerIndex: 3
                ),
                Question(
                    text: "Which is known as the powerhouse of the cell?",
                    answers: ["Mitochondria", "DNA", "Nucleus", "Cell Walls"],
                    correctAnswerIndex: 0
                )
            ]
        )
    ]
}
