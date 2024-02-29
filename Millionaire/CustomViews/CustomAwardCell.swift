
import UIKit

class CustomAwardCell: UITableViewCell {
    
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    
    var gradientColors: [UIColor] = [UIColor.blue, UIColor.green]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.applyGradient(colors: gradientColors)
    }
    
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

    func configure(with award: Amount) {
        leftLabel.text = "Вопрос: \(award.num)"
        rightLabel.text = "\(award.award)"
        
        
        if award.canTake {
            gradientColors = [UIColor(red: 44.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0),
                              UIColor(red: 45.0/255.0, green: 114.0/255.0, blue: 177.0/255.0, alpha: 1.0),
                              UIColor(red: 44.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)]
        } else {
            gradientColors = [UIColor(red: 169.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0),
                              UIColor(red: 93.0/255.0, green: 59.0/255.0, blue: 147.0/255.0, alpha: 1.0),
                              UIColor(red: 169.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0)]
        }
    }
}
