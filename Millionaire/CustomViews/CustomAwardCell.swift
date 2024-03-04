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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boundsDidChanged?(self.bounds)
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
        leftLabel.text = "Question \(award.num)"
        rightLabel.text = "\(award.award) $"
        }
    }

