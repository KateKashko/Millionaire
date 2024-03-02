//
//  CustomAwardCell.swift
//  Millionaire
//
//  Created by Павел Широкий on 27.02.2024.
//

import UIKit
import SnapKit

class CustomAwardCell: UITableViewCell {
    
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    var boundsDidChanged: ((CGRect) -> Void)?
    
    /*override var bounds: CGRect {
        didSet {
            print("contentView.bounds = \(bounds)")
            boundsDidChanged?(self.bounds)
        }
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boundsDidChanged?(self.bounds)
        print("contentView.bounds = \(bounds)")
        
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        self.leftLabel.textColor = .white
        self.rightLabel.textColor = .white
        contentView.contentMode = .scaleAspectFill
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = .init(gray: 255, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 20
        
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        leftLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(15)
            make.centerY.equalToSuperview()
        }
        
        rightLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        // Метод для установки данных в ячейку
    func configure(with award: Amount) {
        leftLabel.text = "Вопрос: \(award.num)"
        rightLabel.text = "\(award.award)"
        }
    }



//
//import UIKit
//
//class CustomAwardCell: UITableViewCell {
//
//    let leftLabel = UILabel()
//    let rightLabel = UILabel()
//
//
//    var gradientColors: [UIColor] = [UIColor.blue, UIColor.green]
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        self.applyGradient(colors: gradientColors)
//    }
//
//    func setupCell() {
//        self.leftLabel.textColor = .white
//        self.rightLabel.textColor = .white
//
//        self.backgroundColor = UIColor.clear
//
//        leftLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(leftLabel)
//        NSLayoutConstraint.activate([
//            leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
//            leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//        ])
//
//        rightLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(rightLabel)
//        NSLayoutConstraint.activate([
//            rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
//            rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//        ])
//    }
//
//    func configure(with award: Amount) {
//        leftLabel.text = "Вопрос: \(award.num)"
//        rightLabel.text = "\(award.award)"
//
//
//        if award.canTake {
//            gradientColors = [UIColor(red: 44.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0),
//                              UIColor(red: 45.0/255.0, green: 114.0/255.0, blue: 177.0/255.0, alpha: 1.0),
//                              UIColor(red: 44.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)]
//        } else {
//            gradientColors = [UIColor(red: 169.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0),
//                              UIColor(red: 93.0/255.0, green: 59.0/255.0, blue: 147.0/255.0, alpha: 1.0),
//                              UIColor(red: 169.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0)]
//        }
//    }
//}
