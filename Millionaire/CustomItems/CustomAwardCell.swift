//
//  CustomAwardCell.swift
//  Millionaire
//
//  Created by Павел Широкий on 27.02.2024.
//

import UIKit

class CustomAwardCell: UITableViewCell {
    
    var sumOfAward = SumOfAward()
    
        let leftLabel = UILabel()
        let rightLabel = UILabel()
        
        func setupCell() {
            
            self.backgroundColor = UIColor.clear
            
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(leftLabel)
            NSLayoutConstraint.activate([
                leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                leftLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])

            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(rightLabel)
            NSLayoutConstraint.activate([
                rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                rightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

        // Метод для установки данных в ячейку
    func configure(with award: Amount) {
        leftLabel.text = "Num: \(award.num)"
        rightLabel.text = "Award: \(award.award)"
        }
    }

