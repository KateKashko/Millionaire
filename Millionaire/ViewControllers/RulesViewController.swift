//
//  RulesViewController.swift
//  Millionaire
//
//  Created by Kate Kashko on 25.02.2024.
//

import UIKit

extension NSMutableAttributedString {
    public func getRangeOfString(textToFind:String)->NSRange{
        let foundRange = self.mutableString.range(of: textToFind)
        return foundRange
    }
}

final class RulesViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "gameBG")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainLabel: UILabel = {
        let element = UILabel()
        element.text = "Rules"
        element.font = .systemFont(ofSize: 40, weight: .medium)
        element.textColor = .white
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var rulesText: UITextView = {
        let content = UITextView()
        let myAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.5, weight: .regular),
                            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
        let myString = NSMutableAttributedString(string: "In order to earn 1 million $, you must correctly answer 15 questions from various fields of knowledge.\n\nEach question has 4 answer options, of which only one is correct. You must answer within 30 seconds.\n\nThere are three fireproof amounts:\n- 1 000 $ \n- 32 000 $ \n- 1 000 000 $\n\nThere are also three tips: \n- 50/50: 2 incorrect answers will disappear. \n- Hall help: the hall will help with the answer.\n-Call a friend: within 30 seconds the player can consult a friend by phone.\n\nYou can withdraw the amount at any time until you answer incorrectly. \n\nCountry game!", attributes: myAttribute )
        content.attributedText = myString
        content.backgroundColor = .clear
        content.isEditable = false
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private let startGameButton = UIButton(title: "Back")
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setViews()
        setupConstraints()
        addAction()
    }
    
    func addAction() {
        startGameButton.addTarget(self, action: #selector(startGameButtonTappet), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        self.startGameButton.applyGradient(colors: [
            UIColor(named: "greenButton") ?? .clear,
            UIColor(named: "greenButtonShadow") ?? .clear,
            UIColor(named: "greenButton") ?? .clear
        ])
    }
    
    @objc private func startGameButtonTappet() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - Extension
extension RulesViewController {
    
    private func setViews() {
        
        view.addSubview(backgroundImageView)
        view.addSubview(mainLabel)
        view.addSubview(rulesText)
        view.addSubview(self.startGameButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 40),
            
            rulesText.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8),
            rulesText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            rulesText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            rulesText.bottomAnchor.constraint(equalTo: startGameButton.topAnchor, constant: -8),
            
            startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.widthAnchor.constraint(equalToConstant: 264),
            startGameButton.heightAnchor.constraint(equalToConstant: 54)
            
        ])
    }
}
