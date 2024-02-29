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
        }

    func getColorOfLabel(colorType: Amount) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()

        switch colorType.canTake {
        case false:
            let colorTop = UIColor(red: 169.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
            let colorMiddle = UIColor(red: 93.0/255.0, green: 59.0/255.0, blue: 147.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 169.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
            gradientLayer.colors = [colorTop,colorMiddle, colorBottom]
        default:
            let colorTop = UIColor(red: 44.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
            let colorMiddle = UIColor(red: 45.0/255.0, green: 114.0/255.0, blue: 177.0/255.0, alpha: 1.0).cgColor
            let colorBottom = UIColor(red: 44.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor
            gradientLayer.colors = [colorTop,colorMiddle, colorBottom]
        }
        return gradientLayer
    }
    
        // Метод для установки данных в ячейку
    func configure(with award: Amount) {
        leftLabel.text = "Вопрос: \(award.num)"
        rightLabel.text = "\(award.award)"
        }
    }

