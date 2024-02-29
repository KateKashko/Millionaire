//
//  CustomGradientButton.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 29.02.2024.
//

import UIKit

class CustomAnswersButton: UIButton {
    
    var currentGradientColors: [UIColor] = UIGradientColors.blueGradientColors {
        didSet {
            applyGradient(colors: currentGradientColors)
        }
    }
    
    private let prefixLabel = UILabel(text: "")
    private let answerLabel = UILabel(text: "")
    
    // MARK: - Init
    init(prefix: String, text: String) {
        super.init(frame: .zero)
        
        setupButton(prefix,text)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyGradient(colors: currentGradientColors)
    }
    
    // MARK: - Public methods and properties
    func updateAnswer(with text: String) {
        answerLabel.text = text
    }
    
    
    func addButtonTarget(target: Any?, action: Selector, tag: Int) {
        addTarget(target, action: action, for: .touchUpInside)
        self.tag = tag
    }

    
    var answerTitle: String {
        answerLabel.text ?? ""
    }
    
    
    // MARK: - Private methods
    private func setupButton(_ prefix: String, _ text: String) {
        
        prefixLabel.text = prefix
        answerLabel.text = text
        
        layer.cornerRadius = 15
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(prefixLabel)
        addSubview(answerLabel)

    }
    
    // MARK: - Objc methods

    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        prefixLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        answerLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: LocalConstants
enum UIGradientColors {
    
    static let blueButtonColor1 = UIColor(named: "blueButton")!
    static let blueButtonColor2 = UIColor(named: "blueButtonShadow")!
    static let blueButtonColor3 = UIColor(named: "blueButton")!
    
    static let blueGradientColors = [blueButtonColor1, blueButtonColor2, blueButtonColor3]
    
    static let redButtonColor1 = UIColor(named: "redButton")!
    static let redButtonColor2 = UIColor(named: "redButtonShadow")!
    static let redButtonColor3 = UIColor(named: "redButton")!
    
    static let redGradientColors = [redButtonColor1, redButtonColor2, redButtonColor3]
    
    static let goldButtonColor1 = UIColor(named: "goldButton")!
    static let goldButtonColor2 = UIColor(named: "goldButtonShadow")!
    static let goldButtonColor3 = UIColor(named: "goldButton")!
    

    static let goldGradientColors = [goldButtonColor1, goldButtonColor2, goldButtonColor3]
    
    static let greenButtonColor1 = UIColor(named: "greenButton")!
    static let greenButtonColor2 = UIColor(named: "greenButtonShadow")!
    static let greenButtonColor3 = UIColor(named: "greenButton")!
    
    static let greenGradientColors = [greenButtonColor1, greenButtonColor1, greenButtonColor3]
}
