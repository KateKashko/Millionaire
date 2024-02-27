import UIKit
import SnapKit

class CustomGradientButton: UIButton {
    
    private let prefixLabel = UILabel(text: "")
    private let answerLabel = UILabel(text: "")
    
    
    let color1 = UIColor(hex: "4872C4").cgColor
    let color2 = UIColor(hex: "203960").cgColor
    let color3 = UIColor(hex: "4872C4").cgColor
    
    lazy var colors = [color1,color2,color3]
    
    // MARK: - Init
    init(prefix: String, text: String) {
        super.init(frame: .zero)
        
        prefixLabel.text = prefix
        answerLabel.text = text
        layer.cornerRadius = 15
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(prefixLabel)
        addSubview(answerLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        applyGradient(colors)
    }
    
    // MARK: - Private func
    private func applyGradient(_ colors: [CGColor]) {
        
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = [0, 0.5, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: -1, c: 1, d: 0, tx: 0, ty: 1))
        gradient.frame = self.bounds
        gradient.cornerRadius = 15
        self.layer.insertSublayer(gradient, at: 0)
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
}


