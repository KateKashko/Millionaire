///
//  ViewController.swift
//  Millionaire
//
//  Created by Kate Kashko on 25.02.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Private Property
    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    private var millionaireImageView = UIImageView()
    private let millionaireImage = UIImage(named: "image")
    
    private let startGameButton = UIButton()
    private let gameRulesButton = UIButton()
    
    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        
        setupMillionaireImage()
        
        setupButton(startGameButton, withTitle: "Начать игру")
        setupButton(gameRulesButton, withTitle: "Правила игры")
        
        setupLayout()
        
        addAction()
        
    }
    
    //MARK: - Actions
    @objc func startGame() {
        self.showLoadingView()
        
        NetworkManager.shared.getQuestion(for: .easy) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let question):
                DispatchQueue.main.async {
                    self.dismissLoadingView()
                    let gameVC = GameViewController(question: question)
                    gameVC.modalPresentationStyle = .fullScreen
                    self.present(gameVC, animated: true)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    @objc func showRules() {
        let rulesVC = RulesViewController()
        rulesVC.modalPresentationStyle = .fullScreen
        present(rulesVC, animated: true)
    }
}

//MARK: - Private Methods
//MARK: - Settings View
private extension MainViewController {
    func setupBackgroundImage() {
        backgroundImage.image = UIImage(named: "mainBG")
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
    }
    
    func setupMillionaireImage() {
        millionaireImageView.image = millionaireImage
        view.addSubview(millionaireImageView)
    }
    
    func setupButton(_ button: UIButton, withTitle title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(button)
    }
    
    func addAction() {
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        gameRulesButton.addTarget(self, action: #selector(showRules), for: .touchUpInside)
    }
}

//MARK: - Layout
private extension MainViewController {
    func setupLayout() {
        millionaireImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            millionaireImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            millionaireImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            millionaireImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            millionaireImageView.heightAnchor.constraint(equalTo: millionaireImageView.widthAnchor)
        ])
        
        gameRulesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameRulesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            gameRulesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameRulesButton.widthAnchor.constraint(equalToConstant: 264),
            gameRulesButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startGameButton.bottomAnchor.constraint(equalTo: gameRulesButton.topAnchor, constant: -30),
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.widthAnchor.constraint(equalToConstant: 264),
            startGameButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}


////MARK: - Preview
//#Preview("MainViewController") {
//    MainViewController()
//}
