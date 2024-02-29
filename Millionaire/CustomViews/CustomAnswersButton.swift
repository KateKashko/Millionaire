import UIKit
import SnapKit

class CustomAnswersButton: UIButton {
    
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
        
        applyGradient(colors: LocalConstants.blueGradientColors)
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
<<<<<<<< HEAD:Millionaire/CustomViews/CustomGradientButton.swift
        
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
========
>>>>>>>> develop:Millionaire/CustomViews/CustomAnswersButton.swift

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
        
        static let goldGradientColors = [redButtonColor1, redButtonColor2, redButtonColor3]
        
        static let greenButtonColor1 = UIColor(named: "greenButton")!
        static let greenButtonColor2 = UIColor(named: "greenButtonShadow")!
        static let greenButtonColor3 = UIColor(named: "greenButton")!
        
        static let greenGradientColors = [redButtonColor1, redButtonColor2, redButtonColor3]
     }
    
    
}



