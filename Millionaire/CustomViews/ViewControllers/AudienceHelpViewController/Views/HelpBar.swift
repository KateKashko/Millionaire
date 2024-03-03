//
//  HelpBar.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 03.03.2024.


import UIKit

extension HelpBar {
    struct Data {
        let value: String
        let heightMultiplier: Double
        let index: Int
        let columnName: String
    }
}

final class HelpBar: BaseView {
    
    var barViewHeightAnchor: NSLayoutConstraint?
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font          = UIFont.systemFont(ofSize: 16)
        label.textColor     = .darkGray
        return label
    }()
    
    private let barView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor    = .systemBlue
        return view
    }()
    
    private let columnNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor     = .label
        label.font          = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var heightMultiplier: Double
    
    init(data: Data) {
        self.heightMultiplier = data.heightMultiplier
        valueLabel.text = data.value
       
        super.init(frame: .zero)
        columnNameLabel.text = data.columnName
    }
    
    required init?(coder: NSCoder) {
        self.heightMultiplier = 0
        super.init(frame: .zero)
    }
    
    var heightConstraint = NSLayoutConstraint()
    
    private func adjustBarViewHeightConstraint() {
        let animator = UIViewPropertyAnimator(
            duration: 0.3,
            curve: .linear) {
                self.heightConstraint = self.barView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: self.heightMultiplier * 0.8)
                self.heightConstraint.isActive = true
                self.layoutIfNeeded()
            }
        animator.startAnimation()
    }
    
}


extension HelpBar {
    
    override func setupViews() {
         super.setupViews()
        addSubviews(columnNameLabel, barView, valueLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        heightConstraint = barView.heightAnchor.constraint(equalToConstant: 1)
        
        NSLayoutConstraint.activate([
            
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 12),
            
            barView.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 2),
            barView.centerXAnchor.constraint(equalTo: centerXAnchor),
            barView.widthAnchor.constraint(equalToConstant: 36),
            
            heightConstraint,
         
            columnNameLabel.topAnchor.constraint(equalTo: barView.bottomAnchor, constant: 4),
            columnNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            columnNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.adjustBarViewHeightConstraint()
        }
        
    }
    
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor     = .secondarySystemBackground
        layer.cornerRadius  = 2.5
        layer.masksToBounds = true
    }
    
    
}
