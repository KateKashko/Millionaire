//
//  ViewController.swift
//  Millionaire
//
//  Created by Kate Kashko on 25.02.2024.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        NetworkManager.shared.getQuestion(for: .easy) { result in
            switch result {
            case .success(let question):
                question.results.forEach {
                    print($0.question.htmlDecoded)
                    print("Correct answer: \($0.correctAnswer)")
                    print("Incorrect answers \($0.incorrectAnswers)")
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }


}

