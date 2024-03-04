//
//  NetworkManager.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 26.02.2024.
//

import Foundation

enum QuestionLevelURL: String {
    case easy
    case medium
    case hard   
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getQuestion(for level: QuestionLevelURL, completed: @escaping (Result<Question, MError>) -> Void) {
        let endpoint = "https://opentdb.com/api.php?amount=1&difficulty=\(level)&type=multiple"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let question = try decoder.decode(Question.self, from: data)
                completed(.success(question))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
