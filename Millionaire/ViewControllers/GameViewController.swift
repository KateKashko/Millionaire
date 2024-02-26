import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    let color1 = UIColor(hex: "4872C4")
    let color2 = UIColor(hex: "203960")
    let color3 = UIColor(hex: "4872C4")
    
    lazy var colors = [color1, color2, color3]
    
    // MARK: - UI
    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "mainBG")
        element.contentMode = .scaleToFill
        return element
    }()
    
    private let mainStackView = UIStackView(
        axis: .vertical,
        distribution: .equalSpacing
    )
    
    private let headerStackView = UIStackView(
        axis: .vertical,
        distribution: .fillProportionally,
        spacing: 5
    )
    
    private let headerHorizontalStackView = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually,
        spacing: 110
    )
      
    private let answersStackView = UIStackView(
        axis: .vertical,
        distribution: .fillEqually,
        alignment: .fill
    )
    
    private let hintsStackView = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually)
    
    private lazy var questionNumber = UILabel(
        text: "Вопрос 1"
    )
    
    private lazy var prizeMoney = UILabel(
        text: "100 RUB"
    )
    
    private lazy var timerLabel = UILabel(
        text: "30",
        font: .systemFont(ofSize: 64, weight: .medium)
    )
    
    private lazy var questionLabel = UILabel (
        text: "Traditonal Chinese painting technique is..."
    )
    
    private lazy var buttonA = UIButton(text: "A: First Option")
    private lazy var buttonB = UIButton(text: "B: Second Option")
    private lazy var buttonC = UIButton(text: "C: Third Option")
    private lazy var buttonD = UIButton(text: "D: Fourth Option")
    
    private lazy var fiftyFiftyButton = UIButton()
    private lazy var friendCallButton = UIButton()
    private lazy var audienceAssistantButton = UIButton()
    
    private let fiftyFiftyImageView = UIImageView(imageName: "5050")
    private let friendCallImageView = UIImageView(imageName: "callToFriend")
    private let audienceAssistantImageView = UIImageView(imageName: "callToFriend")
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [buttonA, buttonB, buttonC, buttonD].forEach { button in
              button.applyGradient(colors)
          }
    }

    
    // MARK: - Setup View
    private func setupView(){
    
        [backgroundImage,mainStackView].forEach { view.addSubview($0)}
        
        [headerStackView, answersStackView, hintsStackView].forEach
        {mainStackView.addArrangedSubview($0)}
        
        [headerHorizontalStackView, timerLabel, questionLabel].forEach
        {headerStackView.addArrangedSubview($0)}
        
        [questionNumber, prizeMoney].forEach
        {headerHorizontalStackView.addArrangedSubview($0)}
        
        [buttonA, buttonB, buttonC, buttonD].forEach
        {answersStackView.addArrangedSubview($0)}
        
        [fiftyFiftyImageView, friendCallImageView, audienceAssistantImageView].forEach
        {hintsStackView.addArrangedSubview($0)}
        
        fiftyFiftyImageView.addSubview(fiftyFiftyButton)
        friendCallImageView.addSubview(friendCallButton)
        audienceAssistantImageView.addSubview(audienceAssistantButton)
        
    }
}

// MARK: - Setup Constraints
extension GameViewController {
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        answersStackView.snp.makeConstraints { make in
            make.height.equalTo(350)
        }
        answersStackView.snp.makeConstraints { make in
            make.width.equalTo(350)
        }
    }
}

// MARK: - UIKit + Extensions
extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        spacing: CGFloat = 10,
        alignment: UIStackView.Alignment = .center
    ){
        self.init()
        
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.alignment = alignment
   
    }
}


extension UIButton {
  
    
    convenience init(text: String? = nil, image: String? = nil) {
        self.init(type: .system)
                
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        self.setTitleColor(.white, for: .normal)
 
    }
}

extension UILabel {
    convenience init(
        text: String,
        font: UIFont = .systemFont(ofSize: 24, weight: .medium)
    ) {
        self.init()
        
        self.numberOfLines = 0
        self.text = text
        self.font = font
        self.textColor = .white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }
}

extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        self.isUserInteractionEnabled = true
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}



extension UIColor {
    convenience init(hex: String,
                     alpha: CGFloat = 1.0) {
        
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        
        switch hex.count {
            
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(red: CGFloat(r) / 255,
                  green: CGFloat(g) / 255,
                  blue: CGFloat(b) / 255,
                  alpha: CGFloat(a) / 255)
    }
}
