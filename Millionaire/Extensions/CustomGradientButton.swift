//
//  CustomGradientButton.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 29.02.2024.
//

import UIKit

class CustomGradientButton: UIButton {
    
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
        
        applyGradient(LocalConstants.mainColors)
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
        
//        addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(buttonTouchUp), for: .touchUpOutside)
    }
    
    func applyGradient(_ colors: [CGColor]) {
        
        let gradient = CAGradientLayer()
        
        gradient.colors = colors
        gradient.locations = [0, 0.5, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: 0, b: -1, c: 1, d: 0, tx: 0, ty: 1)
        )
        gradient.frame = self.bounds
        gradient.cornerRadius = 15
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK: - Objc methods
//    @objc private func buttonTouchDown() {
//        applyGradient(LocalConstants.touchDownColors)
//        print("W")
//    }

     @objc private func buttonTouchUp() {
         applyGradient(LocalConstants.mainColors)
     }
    
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
    
    // MARK: LocalConstants
    private enum LocalConstants {
        
        static let mainButtonColor1 = UIColor(hex: "4872C4").cgColor
        static let mainButtonColor2 = UIColor(hex: "203960").cgColor
        static let mainButtonColor3 = UIColor(hex: "4872C4").cgColor
        
        static let mainColors = [mainButtonColor1, mainButtonColor2, mainButtonColor3]
     }
}
