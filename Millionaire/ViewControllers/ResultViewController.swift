//
//  ResultViewController.swift
//  Millionaire
//
//  Created by Руслан Дырахов on 27.02.2024.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - Properties
    var winningAmount: Int?
    
    // MARK: - Views
    private let backgroundImage = UIImageView()
    private let gameIconImage = UIImageView()
    private let winAmountTextField = UITextField()
    private let winningAmountLabel = UILabel()
    private let playAgainButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupConstraints()
        updateWinningAmountLabel()
    }
    
    // MARK: - Private Methods
    private func updateWinningAmountLabel() {
        if let winningAmount = winningAmount {
            winningAmountLabel.text = "\(winningAmount)＄"
        } else {
            winningAmountLabel.text = "No data"
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
        winAmountTextField.text = "Ваш выигрыш:" // или -You won:
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
    
    // MARK: - Actions
    @objc private func newGameButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
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

#Preview("ResultVC") {
    ResultViewController()
}

//extension UIColor {
//    func hex(_ rgbValue: UInt64) -> UIColor {
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
//}
//
//extension ResultViewController {
//    enum appColors {
//        static let green = UIColor().hex(0x2596BE)
//        static let black = UIColor().hex(0x000000)
//        static let white = UIColor().hex(0xFFFFFF)
//    }
//}
