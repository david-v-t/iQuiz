//
//  GetQuiz.swift
//  iQuiz
//
//  Created by iguest on 2/25/26.
//

import Foundation

class GetQuiz {
    static let shared = GetQuiz()
        
    func localFileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) [0]
        return documentsDirectory.appendingPathComponent("quizzes.json")
    }

    func fetchQuizzes(_ urlString: String, completion: @escaping ([Quiz], Bool) -> Void) {
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    
                    if let data = data,
                       let quizzes = try? JSONDecoder().decode([Quiz].self, from: data) {
                        
                        if let encoded = try? JSONEncoder().encode(quizzes) {
                            try? encoded.write(to: self.localFileURL())
                        }
                        
                        completion(quizzes, true)
                        return
                    }
                        
                    if let localData = try? Data(contentsOf: self.localFileURL()),
                       let localQuizzes = try? JSONDecoder().decode([Quiz].self, from: localData) {
                        
                        completion(localQuizzes, false)
                        return
                    }
                    
                    completion([], false)
                }
                
                .resume()
            }
        }
    
}
