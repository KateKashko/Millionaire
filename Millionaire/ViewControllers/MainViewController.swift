///
//  ViewController.swift
//  Millionaire
//
//  Created by Kate Kashko on 25.02.2024.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    //MARK: - Private Property
    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    private var millionaireImageView = UIImageView()
    private let millionaireImage = UIImage(named: "image")
    
    private let startGameButton = UIButton(title: "Start the game")
    private let gameRulesButton = UIButton(title: "Rules")
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundImage()
        setupMillionaireImage()
        
        addSubview()
        setupLayout()
        addAction()
        
        SoundManager.shared.playSound("startApp")
    }
    
    override func viewDidLayoutSubviews() {
        self.startGameButton.applyGradient(colors: [
            UIColor(named: "greenButton") ?? .clear,
            UIColor(named: "greenButtonShadow") ?? .clear,
            UIColor(named: "greenButton") ?? .clear
        ])
        self.gameRulesButton.applyGradient(colors: [
            UIColor(named: "greenButton") ?? .clear,
            UIColor(named: "greenButtonShadow") ?? .clear,
            UIColor(named: "greenButton") ?? .clear
        ])
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
                    self.navigationController?.pushViewController(gameVC, animated: true)
                    self.navigationItem.hidesBackButton = true
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    @objc func showRules() {
        let rulesVC = RulesViewController()
        self.navigationController?.pushViewController(rulesVC, animated: true)
        self.navigationItem.hidesBackButton = true
    }
}

//MARK: - Private Methods
//MARK: - Settings View
private extension MainViewController {
    func setupBackgroundImage() {
        backgroundImage.image = UIImage(named: "mainBG")
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    func setupMillionaireImage() {
        millionaireImageView.image = millionaireImage
    }
    
    func addSubview() {
        view.addSubview(backgroundImage)
        view.addSubview(millionaireImageView)
        view.addSubview(startGameButton)
        view.addSubview(gameRulesButton)
    }
    
    func addAction() {
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        gameRulesButton.addTarget(self, action: #selector(showRules), for: .touchUpInside)
    }
}

//MARK: - Layout
private extension MainViewController {
    func setupLayout() {
        
        millionaireImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(70)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(millionaireImageView.snp.width)
        }

        gameRulesButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(264)
            make.height.equalTo(54)
        }

        startGameButton.snp.makeConstraints { make in
            make.bottom.equalTo(gameRulesButton.snp.top).offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalTo(264)
            make.height.equalTo(54)
        }
    }
}


