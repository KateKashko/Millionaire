import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    // MARK: - UI
    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.image = LocalConstants.mainBGImage
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
        spacing: 20,
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
        text: "Traditonal Chinese painting technique is...Traditonal Chinese painting technique is...Traditonal Chinese painting technique is...Traditonal Chinese painting technique is..."
    )
    
    private lazy var buttonA = CustomGradientButton(prefix: "A", text: "First Option")
    private lazy var buttonB = CustomGradientButton(prefix: "B", text: "Second Option")
    private lazy var buttonC = CustomGradientButton(prefix: "C", text: "Third Option")
    private lazy var buttonD = CustomGradientButton(prefix: "D", text: "Other Option")
    
    private lazy var fiftyFiftyButton = UIButton()
    private lazy var friendCallButton = UIButton()
    private lazy var audienceAssistantButton = UIButton()
    
    private let fiftyFiftyImageView = UIImageView(imageName: "5050")
    private let friendCallImageView = UIImageView(imageName: "callToFriend")
    private let audienceAssistantImageView = UIImageView(imageName: "help")
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
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
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        answersStackView.snp.makeConstraints { make in
            make.height.equalTo(250)
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


// MARK: LocalConstants
private enum LocalConstants {
    
    static let mainBGImage = UIImage(named: "mainBG")
    static let imageViewHorizontalInset: CGFloat = 10
    static let imageViewHeight: CGFloat = 300
 }
