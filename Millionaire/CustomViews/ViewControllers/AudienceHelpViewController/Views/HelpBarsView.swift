//
//  HelpBarsView.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 03.03.2024.
//

import UIKit

final class HelpBarsView: BaseView {
    

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    func configure(with data: [HelpBar.Data]) {
        data.forEach {
            let barView = HelpBar(data: $0)
            stackView.addArrangedSubview(barView)
        }
    }

    
}


extension HelpBarsView {
    
    override func setupViews() {
        super.setupViews()
        addSubviews(stackView)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    override func constraintViews() {
        super.constraintViews()
  
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        stackView.backgroundColor = .secondarySystemBackground
    }
    
}
