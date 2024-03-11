//
//  ResultViewController.swift
//  Millionaire
//
//  Created by Руслан Дырахов on 27.02.2024.
//

import UIKit
import SnapKit

final class ResultViewController: UIViewController {
    
    // MARK: - Properties
    private var winningAmount: Int?
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "gameBG")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var gameIconImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "image")
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var winAmountLabel: UILabel = {
        let element = UILabel()
        element.text = "You win:"
        element.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var winningAmountLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private let playAgainButton = UIButton(title: "Play again")
   
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setViews()
        setupConstraints()
        updateWinningAmountLabel()
        addAction()
    }
    
    func addAction() {
        playAgainButton.addTarget(self, action: #selector(startGameButtonTappet), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        self.playAgainButton.applyGradient(colors: [
            UIColor(named: "greenButton") ?? .clear,
            UIColor(named: "greenButtonShadow") ?? .clear,
            UIColor(named: "greenButton") ?? .clear
        ])
    }
    
    // MARK: - Private Methods
    @objc private func startGameButtonTappet() {
        PersistenceManager.defaults.set(false, forKey: PersistenceManager.Keys.isAudienceHelpUsed)
        PersistenceManager.defaults.set(false, forKey: PersistenceManager.Keys.isFiftyFiftyUsed)
        PersistenceManager.defaults.set(false, forKey: PersistenceManager.Keys.isFriendCallUsed)
        let mainVC = MainViewController()
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
   
    func setWinningAmount(_ amount: Int) {
        winningAmount = amount
        updateWinningAmountLabel()
    }
    
    private func updateWinningAmountLabel() {
        if let winningAmount = winningAmount {
            winningAmountLabel.text = "\(winningAmount) $"
        } else {
            winningAmountLabel.text = "0 $"
        }
    }
}

extension ResultViewController {
    
    private func setViews() {
        
        view.addSubview(backgroundImageView)
        view.addSubview(gameIconImage)
        view.addSubview(winAmountLabel)
        view.addSubview(winningAmountLabel)
        view.addSubview(self.playAgainButton)
    }

    private func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        gameIconImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(201)
        }
        
        winAmountLabel.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(gameIconImage.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
        }
        
        winningAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(winAmountLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        playAgainButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(264)
            make.height.equalTo(54)
        }
    }
}
