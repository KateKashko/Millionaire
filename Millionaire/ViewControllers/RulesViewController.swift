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
    
    private let startGameButton: UIButton = {
        let element = UIButton()
        element.setTitle("Начать игру", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        element.layer.cornerRadius = 15
        element.layer.borderColor = UIColor.white.cgColor
        element.layer.borderWidth = 1
        //        element.addTarget(self, action: #selector(startGameButtonTappet), for: .touchUpInside)
        //
        //        let gradient = CAGradientLayer()
        //            gradient.colors = [
        //                UIColor(red: 139 / 255, green: 236 / 255, blue: 90 / 255, alpha: 1).cgColor,
        //                UIColor(red: 65 / 255, green: 179 / 255, blue: 70 / 255, alpha: 1).cgColor,
        //                UIColor(red: 139 / 255, green: 236 / 255, blue: 90 / 255, alpha: 1).cgColor
        //            ]
        //            gradient.locations = [0, 0.5, 1]
        //            gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        //            gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        //            gradient.frame = CGRect(x: 0, y: 0, width: element.bounds.width, height: element.bounds.height)
        //            element.layer.insertSublayer(gradient, at: 0)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
    }
    
    @objc private func startGameButtonTappet() {
    }
    
}

extension ViewController {
    
    private func setViews() {
        
        view.addSubview(backgroundImageView)
        view.addSubview(mainLabel)
        view.addSubview(rulesText)
        view.addSubview(startGameButton)
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

