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
            contentView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor)
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
        tableView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.widthAnchor.constraint(equalToConstant: 350)
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
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -50)
        ])
    }
    
    func addAction() {
        nextQuestionButton.addTarget(self, action: #selector(continueGame), for: .touchUpInside)
    }
    
    @objc func continueGame() {
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
        let gradientLayer = cell.getColorOfLabel(colorType: amount)
        cell.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = cell.bounds
        cell.layer.cornerRadius = 20
        gradientLayer.cornerRadius = 20
        return cell
    }
}






    /*
private func setupScrollView() {
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(scrollView)

    let margins = view.layoutMarginsGuide
      let frameLayoutGuide = scrollView.frameLayoutGuide

      NSLayoutConstraint.activate([
           frameLayoutGuide.leadingAnchor.constraint(equalTo:
                                                        margins.leadingAnchor),
           frameLayoutGuide.trailingAnchor.constraint(equalTo:
                                                        margins.trailingAnchor),
           frameLayoutGuide.topAnchor.constraint(equalTo:
              view.safeAreaLayoutGuide.topAnchor, constant: 10),
           frameLayoutGuide.bottomAnchor.constraint(equalTo:
             view.safeAreaLayoutGuide.bottomAnchor),
      ])
    }
let contentLayoutGuide = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
          mainStackView.widthAnchor.constraint(equalTo: contentLayoutGuide.widthAnchor),
          mainStackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
          mainStackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
          mainStackView.topAnchor.constraint(equalTo:
               contentLayoutGuide.topAnchor),
          mainStackView.bottomAnchor.constraint(equalTo:
               contentLayoutGuide.bottomAnchor),

          contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
          ])
*/
