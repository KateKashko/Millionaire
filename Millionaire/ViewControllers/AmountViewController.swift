//
//  AmountTableViewController.swift
//  Millionaire
//
//  Created by Kate Kashko on 25.02.2024.
//

import UIKit

class AmountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let backGround = UIImageView()
    let tableView = UITableView()
    let sumOfAward = SumOfAward()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        setupBackground()
        setupTableView()
        
    }

    private func setupBackground() {
            view.addSubview(backGround)
            backGround.image = UIImage(named: "mainBG")
            backGround.contentMode = .scaleAspectFill
            
            backGround.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                backGround.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                backGround.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backGround.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backGround.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        backGround.addSubview(tableView)
        tableView.contentMode = .scaleAspectFill
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: backGround.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: backGround.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: backGround.trailingAnchor,constant: -20),
            tableView.bottomAnchor.constraint(equalTo: backGround.bottomAnchor, constant: -30)
        ])
        
        tableView.register(CustomAwardCell.self, forCellReuseIdentifier: "customCell")
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        cell.layer.cornerRadius = 15
        gradientLayer.cornerRadius = 20
        return cell
    }
    
}
