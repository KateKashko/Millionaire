//
//  ResultViewController.swift
//  Millionaire
//
//  Created by Руслан Дырахов on 27.02.2024.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - Properties
    private var winningAmount: Int?
    
    // MARK: - Views
    private let backgroundImage = UIImageView()
    private let gameIconImage = UIImageView()
    private let winAmountTextField = UITextField()
    private let winningAmountLabel = UILabel()
    private let playAgainButton = UIButton()
    private let closeButton = UIButton(type: .custom)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupConstraints()
        updateWinningAmountLabel()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        backgroundImage.alpha = 0.0
        
        UIView.animate(withDuration: 3) {
            self.backgroundImage.alpha = 1.0
        }
    }
    
    // MARK: - Private Methods
    func setWinningAmount(_ amount: Int) {
        winningAmount = amount
        updateWinningAmountLabel()
    }
    
    private func updateWinningAmountLabel() {
        if let winningAmount = winningAmount {
            winningAmountLabel.text = "\(winningAmount) P"
        } else {
            winningAmountLabel.text = "0 рубликов, 0"
        }
    }
}

extension ResultViewController {
    
    // MARK: - Layout
    private func setupLayout() {
        setupBackgroundImageView()
        setupGameIconImage()
        setupWinAmountTextField()
        setupWinAmountLabel()
        setupPlayAgainButton()
        setupCloseButton()
    }
    
    private func setupBackgroundImageView() {
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "gameBG")
    }
    
    private func setupGameIconImage() {
        view.addSubview(gameIconImage)
        gameIconImage.translatesAutoresizingMaskIntoConstraints = false
        gameIconImage.image = UIImage(named: "image")
        gameIconImage.contentMode = .scaleAspectFill
    }
    
    private func setupWinAmountTextField() {
        view.addSubview(winAmountTextField)
        winAmountTextField.translatesAutoresizingMaskIntoConstraints = false
        winAmountTextField.text = "Ваш выигрыш:"
        winAmountTextField.isUserInteractionEnabled = false
        winAmountTextField.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        winAmountTextField.textColor = .white
    }
    
    private func setupWinAmountLabel() {
        view.addSubview(winningAmountLabel)
        winningAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        winningAmountLabel.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        winningAmountLabel.textColor = .white
    }
    
    private func setupPlayAgainButton() {
        view.addSubview(playAgainButton)
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        playAgainButton.setTitle("Новая игра", for: .normal)
        playAgainButton.setTitleColor(.gray, for: .highlighted)
        playAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        playAgainButton.layer.borderWidth = 2
        playAgainButton.layer.borderColor = UIColor.white.cgColor
        playAgainButton.layer.cornerRadius = 15
        playAgainButton.backgroundColor = .green
        playAgainButton.setTitleColor(.white, for: .normal)
        playAgainButton.addTarget(self, action: #selector(newGameButtonTapped), for: .touchUpInside)
    }
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30)
        let closeImage = UIImage(systemName: "gobackward", withConfiguration: symbolConfiguration)
        
        closeButton.setImage(closeImage, for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func newGameButtonTapped() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .coverVertical
        self.present(mainVC, animated: true)
    }
    // Close Button Action
    @objc private func closeButtonTapped() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                  dismiss(animated: true, completion: nil)
                  return
            }
                  let mainVC = MainViewController()
                  mainVC.modalPresentationStyle = .fullScreen
                  mainVC.modalTransitionStyle = .crossDissolve
            
                  if let rootViewController = sceneDelegate.window?.rootViewController {
                  rootViewController.dismiss(animated: true) {
                  rootViewController.present(mainVC, animated: true, completion: nil)
                }
            }
        }
    
    // MARK: - Constraints
    private func setupConstraints() {
        
        let maximumDistance: CGFloat = 100
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            gameIconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            gameIconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameIconImage.widthAnchor.constraint(equalToConstant: 201),
            gameIconImage.heightAnchor.constraint(equalToConstant: 201),
            
            winAmountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winAmountTextField.topAnchor.constraint(lessThanOrEqualTo: gameIconImage.bottomAnchor, constant: maximumDistance),
            
            winningAmountLabel.topAnchor.constraint(equalTo: winAmountTextField.bottomAnchor, constant: 20),
            winningAmountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playAgainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playAgainButton.widthAnchor.constraint(equalToConstant: 264),
            playAgainButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}
