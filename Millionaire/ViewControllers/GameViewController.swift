import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    private var gameTimer: Timer?
    private var remainingTime = LocalConstants.numberOfSeconds
    
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
        distribution: .fillProportionally
    )
    
    private let headerHorizontalStackView = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually
    )
      
    private let answersStackView = UIStackView(
        axis: .vertical,
        distribution: .fillEqually,
        spacing: 20,
        alignment: .fill
    )
    
    private let hintsStackView = UIStackView(
        axis: .horizontal,
        distribution: .fillEqually
    )
    
    private let questionNumber = UILabel(
        text: "Вопрос 1"
    )
    
    private let prizeMoney = UILabel(
        text: "100 RUB"
    )
    
    private lazy var timerLabel = UILabel(
        text: "\(remainingTime)",
        font: .systemFont(ofSize: 64, weight: .medium)
    )
    
    private let questionLabel = UILabel (
        text: "Traditonal Chinese painting technique is...Traditonal Chinese painting technique is...Traditonal Chinese painting technique is...Traditonal Chinese ")
    
    private let buttonA = CustomAnswersButton(prefix: "A", text: "First Option")
    private let buttonB = CustomAnswersButton(prefix: "B", text: "SecondOlet")
    private let buttonC = CustomAnswersButton(prefix: "C", text: "Third Option")
    private let buttonD = CustomAnswersButton(prefix: "D", text: "Other Option")
    
    private let fiftyFiftyButton = UIButton()
    private let friendCallButton = UIButton()
    private let audienceAssistantButton = UIButton()
    private let takeMoneyButton = UIButton()
    
    private let fiftyFiftyImageView = UIImageView(
        withImage: LocalConstants.fiftyFiftyImage
    )
    private let friendCallImageView = UIImageView(
        withImage: LocalConstants.friendCallImage
    )
    private let audienceAssistantImageView = UIImageView(
        withImage: LocalConstants.audienceHelpImage
    )
    private let takeMoneyImageView = UIImageView(
        withImage: LocalConstants.takeMoneyImage
    )
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        setupConstraints()
        SoundManager.shared.playSound(LocalConstants.waitForResponseSound)
        startTimer()
        
        
    }

    // MARK: - Private methods
    private func setupActions() {

        fiftyFiftyButton.addTarget(self, action: #selector(fiftyFiftyTapped), for: .touchUpInside)
        friendCallButton.addTarget(self, action: #selector(friendCallTapped), for: .touchUpInside)
        audienceAssistantButton.addTarget(self, action: #selector(audienceAssistantTapped), for: .touchUpInside)
        
        takeMoneyButton.addTarget(self, action: #selector(takeMoneyTapped), for: .touchUpInside)
    }
    
    private func startTimer() {
        gameTimer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(updateTimer),
        userInfo: nil,
        repeats: true
       )
    }
    
    private func goToResultViewController() {
        let resultVC = ResultViewController()
        self.present(resultVC, animated: true, completion: nil)
    }
    
    // MARK: - Objc methods
    @objc private func fiftyFiftyTapped(_ sender: UIButton) {
        fiftyFiftyImageView.image = LocalConstants.fiftyFiftyUsedImage
    }
    @objc private func friendCallTapped() {
        friendCallImageView.image = LocalConstants.friendCallUsedImage
    }
    
    @objc private func audienceAssistantTapped() {
        audienceAssistantImageView.image = LocalConstants.audienceHelpUsedImage
    }
    
    @objc private func takeMoneyTapped() {
        SoundManager.shared.playSound(LocalConstants.victoryMillion)
        
        goToResultViewController()
    }

    
    @objc private func updateTimer(){
        
        remainingTime -= 1
        timerLabel.text = "\(remainingTime)"
        
        if remainingTime <= 0 {
            
            gameTimer?.invalidate()
            gameTimer = nil
            
            goToResultViewController()
        }
    }
    // MARK: - Setup View
    private func setupView(){
    
        [backgroundImage,mainStackView].forEach { view.addSubview($0)}
        
        [headerStackView, answersStackView, hintsStackView].forEach
        {mainStackView.addArrangedSubview($0)}
        
        [headerHorizontalStackView, timerLabel, questionLabel].forEach
        {headerStackView.addArrangedSubview($0)}
        
        [questionNumber, takeMoneyImageView, prizeMoney].forEach
        {headerHorizontalStackView.addArrangedSubview($0)}
        
        [buttonA, buttonB, buttonC, buttonD].forEach
        {answersStackView.addArrangedSubview($0)}
        
        [fiftyFiftyImageView, friendCallImageView, audienceAssistantImageView].forEach
        {hintsStackView.addArrangedSubview($0)}
        
        fiftyFiftyImageView.addSubview(fiftyFiftyButton)
        friendCallImageView.addSubview(friendCallButton)
        audienceAssistantImageView.addSubview(audienceAssistantButton)
        takeMoneyImageView.addSubview(takeMoneyButton)
        
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
        
        takeMoneyImageView.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        fiftyFiftyButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        friendCallButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        audienceAssistantButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        takeMoneyButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: LocalConstants
private enum LocalConstants {
    
    static let mainBGImage = UIImage(named: "mainBG")
    static let fiftyFiftyImage = UIImage(named: "5050")
    static let friendCallImage = UIImage(named: "callToFriend")
    static let audienceHelpImage = UIImage(named: "help")
    static let fiftyFiftyUsedImage = UIImage(named: "5050Used")
    static let friendCallUsedImage = UIImage(named: "callToFriendUsed")
    static let audienceHelpUsedImage = UIImage(named: "helpUsed")
    static let takeMoneyImage = UIImage(named: "monetization_on")
    static let numberOfSeconds = 30
    static let waitForResponseSound = "waitForResponse"
    static let victoryMillion = "victoryMillion"
 }
