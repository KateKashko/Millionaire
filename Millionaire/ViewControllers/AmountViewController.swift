//
//  AmountTableViewController.swift
//  Millionaire
//
//  Created by Kate Kashko on 25.02.2024.
//

import UIKit

class AmountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let scrollview = UIScrollView()
    let contentView = UIView()
    let backGround = UIImageView()
    let tableView = UITableView()
    let nextQuestionButton = UIButton()
    let sumOfAward = SumOfAward()
    var previousQuestionIndex: Int = 1
    var onDismiss: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupBackground()
        setupScrollView()
        setupTableView()
        setupQuestionButton(nextQuestionButton, withTitle: "Следующий вопрос")
        addAction()
        
        SoundManager.shared.playSound("correctAnswer")
    }
    
    func setupScrollView() {
        view.addSubview(scrollview)
        scrollview.alwaysBounceVertical = false
        
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollview.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollview.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 920)
        ])
    }
    
    func setupBackground() {
        contentView.addSubview(backGround)
        backGround.image = UIImage(named: "mainBG")
        backGround.contentMode = .scaleAspectFill
        
       backGround.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backGround.topAnchor.constraint(equalTo: contentView.topAnchor),
            backGround.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backGround.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backGround.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        contentView.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.contentMode = .scaleAspectFill
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
        
        tableView.register(CustomAwardCell.self, forCellReuseIdentifier: "customCell")
    }
    
    func setupQuestionButton(_ button: UIButton, withTitle title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        contentView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -50)
        ])
    }
    
    func addAction() {
        nextQuestionButton.addTarget(self, action: #selector(continueGame), for: .touchUpInside)
    }
    
    @objc func continueGame() {
        self.showLoadingView()
        
        if previousQuestionIndex < 15 {
            NetworkManager.shared.getQuestion(for: .easy) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let question):
                    DispatchQueue.main.async {
                        self.dismissLoadingView()
                        let gameVC = GameViewController(question: question)
                        let updatedIndex = self.previousQuestionIndex + 1
                        self.onDismiss?(updatedIndex)
                        gameVC.modalPresentationStyle = .fullScreen
                        self.present(gameVC, animated: true)
                    }
                case .failure(let error):
                    print(error.rawValue)
                }
            }
        } else {
            print("вы выйграли")
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sumOfAward.sumOfAward.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomAwardCell
        
        cell.setupCell()
        let amount = sumOfAward.sumOfAward[indexPath.row]
        cell.configure(with: amount)
        let gradientLayer = getColorOfLabel(index: amount)
        cell.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = cell.bounds
        cell.layer.cornerRadius = 20
        gradientLayer.cornerRadius = 20
        return cell
    }
}

extension AmountViewController {
    
    func getColorOfLabel(index: Amount) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()

        switch index.num {
        case previousQuestionIndex:
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



