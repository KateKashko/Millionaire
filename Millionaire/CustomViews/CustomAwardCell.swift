//
//  CustomAwardCell.swift
//  Millionaire
//
//  Created by Павел Широкий on 27.02.2024.
//

import UIKit

class CustomAwardCell: UITableViewCell {
    
        let leftLabel = UILabel()
        let rightLabel = UILabel()
        
        func setupCell() {
            
            self.leftLabel.textColor = .white
            self.rightLabel.textColor = .white
            
            self.backgroundColor = UIColor.clear
            
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(leftLabel)
            NSLayoutConstraint.activate([
                leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])

            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(rightLabel)
            NSLayoutConstraint.activate([
                rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            
            NSLayoutConstraint.activate([
                contentView.heightAnchor.constraint(equalToConstant: 50) 
            ])
        }
    
        // Метод для установки данных в ячейку
    func configure(with award: Amount) {
        leftLabel.text = "Вопрос: \(award.num)"
        rightLabel.text = "\(award.award)"
        }
    }

