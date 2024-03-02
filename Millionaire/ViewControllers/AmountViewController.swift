//
//  AmountTableViewController.swift
//  Millionaire
//
//  Created by Pavel Shirokii on 25.02.2024.
//

import UIKit
import SnapKit

class AmountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let backGround = UIImageView()
    let tableView = UITableView()
    lazy var nextQuestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Следующий вопрос", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(continueGame), for: .touchUpInside)
        return button
    }()
    let sumOfAward = SumOfAward()
    var currentQuestionIndex = 0
    var gameVC: GameViewController?
    
    init(currentQuestionIndex: Int) {
            super.init(nibName: nil, bundle: nil)
            self.currentQuestionIndex = currentQuestionIndex
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        setupBackground()
        setupTableView()
        setupLayout()
    }

    
    func setupViews() {
        view.addSubview(backGround)
        view.addSubview(tableView)
        view.addSubview(nextQuestionButton)
    }
    
    func setupLayout() {
        backGround.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(nextQuestionButton.snp.top).offset(-10)
        }
        
        nextQuestionButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
    }
    
    func setupBackground() {
        backGround.image = UIImage(named: "mainBG")
        backGround.contentMode = .scaleAspectFill
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.register(CustomAwardCell.self, forCellReuseIdentifier: "customCell")
        print(currentQuestionIndex)
    }
    
    
    @objc func continueGame() {
        self.showLoadingView()

        if currentQuestionIndex < 15 {
            NetworkManager.shared.getQuestion(for: .easy) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let question):
                    DispatchQueue.main.async {
                        self.dismissLoadingView()
                        let gameVC = GameViewController(question: question)
                        gameVC.currentQuestionIndex = self.saveGameProgress(questionIndex: self.currentQuestionIndex)
                        self.navigationController?.pushViewController(gameVC, animated: true)
                    }
                case .failure(let error):
                    print(error.rawValue)
                }
                                                           
        switch currentQuestionIndex {
        case 0...4: getQuestion(difficulty: .easy)
        case 5...9: getQuestion(difficulty: .medium)
        case 10...14: getQuestion(difficulty: .hard)
        default: print("Вы выиграли 1 млн руб!")
        }
    }
    
    
    private func showGameViewController(with question: Question) {
        DispatchQueue.main.async {
            self.dismissLoadingView()
            let gameVC = GameViewController(question: question)
            gameVC.currentQuestionIndex = self.currentQuestionIndex
            gameVC.modalPresentationStyle = .fullScreen
            self.present(gameVC, animated: true)
        }
    }
    
    
    private func getQuestion(difficuly level: QuestionLevelURL) {
        NetworkManager.shared.getQuestion(for: level) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let question):
                self.showGameViewController(with: question)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sumOfAward.sumOfAward.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomAwardCell
        
        let amount = sumOfAward.sumOfAward[indexPath.row]
        cell.configure(with: amount)
        
        cell.boundsDidChanged = { [weak self] bounds in
            guard let self = self else { return }
            let gradientLayer = self.getColorOfLabel(index: amount, viewbounds: bounds)
            cell.layer.insertSublayer(gradientLayer, at: 0)
            gradientLayer.cornerRadius = 20
        }
        return cell
    }
}

extension AmountViewController {
    
    func getColorOfLabel(index: Amount, viewbounds: CGRect) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewbounds

        switch index.num {
        case currentQuestionIndex:
            let colorTop = UIColor(red: 139.0/255.0, green: 236.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
            let colorMiddle = UIColor(red: 65.0/255.0, green: 179.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 139.0/255.0, green: 236.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
            gradientLayer.colors = [colorTop,colorMiddle, colorBottom]
        case 5, 10:
            let colorTop = UIColor(red: 44.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
            let colorMiddle = UIColor(red: 45.0/255.0, green: 114.0/255.0, blue: 177.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 44.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
            gradientLayer.colors = [colorTop,colorMiddle, colorBottom]
        case 15:
            let colorTop = UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 87.0/255.0, alpha: 1.0).cgColor
            let colorMiddle = UIColor(red: 189.0/255.0, green: 154.0/255.0, blue: 31.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 250.0/255.0, green: 214.0/255.0, blue: 87.0/255.0, alpha: 1.0).cgColor
            gradientLayer.colors = [colorTop,colorMiddle, colorBottom]
        default:
            let colorTop = UIColor(red: 169.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
            let colorMiddle = UIColor(red: 93.0/255.0, green: 59.0/255.0, blue: 147.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 169.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
            gradientLayer.colors = [colorTop,colorMiddle, colorBottom]
        }
        return gradientLayer
    }
}



