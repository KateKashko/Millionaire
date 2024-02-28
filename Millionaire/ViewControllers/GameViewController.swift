import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    private var gameTimer: Timer?
    private var remainingTime = LocalConstants.numberOfSeconds
    
    let question: Question
    var allAnswers: [String] = []
    var correctAnswer: String = ""
    var incorrectAnswers: [String] = []
    
    init(question: Question) {
        self.question = question
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private let buttonA = CustomGradientButton(prefix: "A", text: "First Option")
    private let buttonB = CustomGradientButton(prefix: "B", text: "SecondOlet")
    private let buttonC = CustomGradientButton(prefix: "C", text: "Third Option")
    private let buttonD = CustomGradientButton(prefix: "D", text: "Other Option")
    
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
        startTimer()
        setupValuesForAnswers()
        addButtonsTargets()
        updateUI()
    }

    
    private func setupValuesForAnswers() {
        correctAnswer    = question.results[0].correctAnswer
        incorrectAnswers = question.results[0].incorrectAnswers
        allAnswers.append(correctAnswer)
        allAnswers.append(contentsOf: incorrectAnswers)
        allAnswers.shuffle()
    }
    
    
    private func updateUI() {
        questionLabel.text = question.results[0].question.htmlDecoded
        
        buttonA.updateAnswer(with: allAnswers[1].htmlDecoded)
        buttonB.updateAnswer(with: allAnswers[0].htmlDecoded)
        buttonC.updateAnswer(with: allAnswers[3].htmlDecoded)
        buttonD.updateAnswer(with: allAnswers[2].htmlDecoded)
    }
    
    
    private func addButtonsTargets() {
        buttonA.addButtonTarget(target: self, action: #selector(checkAnswer), tag: 0)
        buttonB.addButtonTarget(target: self, action: #selector(checkAnswer), tag: 1)
        buttonC.addButtonTarget(target: self, action: #selector(checkAnswer), tag: 2)
        buttonD.addButtonTarget(target: self, action: #selector(checkAnswer), tag: 3)
    }
    
    
    @objc private func checkAnswer(sender: CustomGradientButton) {
        if sender.answerTitle == self.correctAnswer {
            print("Correct!")
        } else {
            print("Incorrect!")
        }
    }
    
    
    // MARK: - Private methods
    private func setupActions() {

        fiftyFiftyButton.addTarget(self, action: #selector(fiftyFiftyTapped), for: .touchUpInside)
        friendCallButton.addTarget(self, action: #selector(friendCallTapped), for: .touchUpInside)
        audienceAssistantButton.addTarget(self, action: #selector(audienceAssistantTapped), for: .touchUpInside)
        
//        takeMoneyButton.addTarget(self, action: #selector(takeMoneyTapped), for: .touchUpInside)
    }
    
    private func startTimer() {
       let gameTimer = Timer.scheduledTimer(
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
 }
