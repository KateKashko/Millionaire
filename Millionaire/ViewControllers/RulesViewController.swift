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
        element.text = "Правила игры"
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
        let myString = NSMutableAttributedString(string: "Для того чтобы заработать 1 миллион рублей необходимо правильно ответить на 15 вопросов из различных областей знаний.\n\nКаждый вопрос имеет 4 варианта ответа, из которых только один верный.\n\nСуществуют три несгораемых суммы:\n- 1 000 рублей \n- 32 000 рублей \n- 1 000 000 рублей\n\nТакже есть три подсказки: \n- 50/50: исчезнут 2 неверных ответа. \n- Помощь зала: зал поможет с ответом.\n-Звонок другу: в течении 30 секунд игрок может посоветоваться с другом по телефону.\n\nВы можете забрать сумму в любой момент, пока не ответили неверно. \n\nУдачной игры!", attributes: myAttribute )
        content.attributedText = myString
        content.backgroundColor = .clear
        content.isEditable = false
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private let startGameButton = UIButton(title: "На главную")
    
    
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
