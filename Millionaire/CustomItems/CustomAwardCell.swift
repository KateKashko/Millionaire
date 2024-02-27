//
//  CustomAwardCell.swift
//  Millionaire
//
//  Created by Павел Широкий on 27.02.2024.
//

import UIKit

class CustomAwardCell: UITableViewCell {

        // Левый и правый UILabel
        let leftLabel = UILabel()
        let rightLabel = UILabel()

        // Метод для настройки внешнего вида ячейки
        func setupCell() {
            // Настройте левый UILabel
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(leftLabel)
            NSLayoutConstraint.activate([
                leftLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                leftLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])

            // Настройте правый UILabel
            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(rightLabel)
            NSLayoutConstraint.activate([
                rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                rightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

        // Метод для установки данных в ячейку
        func configure(with amount: Amount) {
            leftLabel.text = "Num: \(amount.num)"
            rightLabel.text = "Award: \(amount.award)"
        }
    }

