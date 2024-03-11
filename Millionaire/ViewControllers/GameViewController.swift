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
    var currentQuestionIndex = 0
    var currentWinningAmount = 100
    
    // Button's State Properties
    var isAudienceHelpUsed = false
    var isFiftyFiftyUsed = false
    var isFriendCallUsed = false
    
    // MARK: - Init
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
        distribution: .fillEqually
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
    
    private lazy var questionNumber = UILabel(
        text: "Question \(currentQuestionIndex + 1)"
    )
    
    private lazy var prizeMoney = UILabel(
        text: "\(currentWinningAmount) $"
        
    )
        
    private let questionLabel = UILabel (
        text: "")
    
    private let buttonA = CustomAnswersButton(prefix: "A", text: "")
    private let buttonB = CustomAnswersButton(prefix: "B", text: "")
    private let buttonC = CustomAnswersButton(prefix: "C", text: "")
    private let buttonD = CustomAnswersButton(prefix: "D", text: "")
    
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
    
    private lazy var timerLabel = UILabel(
        text: "\(remainingTime)",
        font: .systemFont(ofSize: 64, weight: .medium)
    )
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupView()
        setupActions()
        setupConstraints()
        SoundManager.shared.playSound(LocalConstants.waitForResponseSound)
        startTimer()
        setupValuesForAnswers()
        addButtonsTargets()
        setHelperButtonStates()
        updateUI()
    }
    
    
    private func setHelperButtonStates() {
        //audienceAssistantButton state
        isFiftyFiftyUsed = PersistenceManager.defaults.value(forKey: PersistenceManager.Keys.isFiftyFiftyUsed) as? Bool ?? false
        fiftyFiftyImageView.image = isFiftyFiftyUsed ? LocalConstants.fiftyFiftyUsedImage : LocalConstants.fiftyFiftyImage
        fiftyFiftyButton.isEnabled = !isFiftyFiftyUsed
        
        // TODO: friendCallButton state....
        
        // Исправленное присваивание для isAudienceHelpUsed
        isAudienceHelpUsed = PersistenceManager.defaults.value(forKey: PersistenceManager.Keys.isAudienceHelpUsed) as? Bool ?? false
        audienceAssistantImageView.image = isAudienceHelpUsed ? LocalConstants.audienceHelpUsedImage : LocalConstants.audienceHelpImage
        audienceAssistantButton.isEnabled = !isAudienceHelpUsed
        
        isFriendCallUsed = PersistenceManager.defaults.value(forKey: PersistenceManager.Keys.isFriendCallUsed) as? Bool ?? false
        friendCallImageView.image = isFriendCallUsed ? LocalConstants.friendCallUsedImage : LocalConstants.friendCallImage
        friendCallButton.isEnabled = !isFriendCallUsed
        
    }
    
    
    
    private func setupValuesForAnswers() {
        correctAnswer    = question.results[0].correctAnswer
        incorrectAnswers = question.results[0].incorrectAnswers
        allAnswers.append(correctAnswer)
        allAnswers.append(contentsOf: incorrectAnswers)
        allAnswers.shuffle()
        print(correctAnswer)
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
    
    
    @objc private func checkAnswer(sender: CustomAnswersButton) {
       
        [buttonA, buttonB, buttonC, buttonD].forEach {
            $0.isEnabled = false
        }
        
        sender.currentGradientColors = UIGradientColors.goldGradientColors
        SoundManager.shared.playSound(LocalConstants.waitForInspectionSound)
        gameTimer?.invalidate()
        
        if sender.answerTitle.compare(self.correctAnswer, options: .diacriticInsensitive) == .orderedSame {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                sender.currentGradientColors = UIGradientColors.greenGradientColors
                SoundManager.shared.playSound(LocalConstants.correctAnswerSound)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.currentQuestionIndex += 1
                    self.goToAmountViewController(withQuestionIndex: self.currentQuestionIndex)
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                sender.currentGradientColors = UIGradientColors.redGradientColors
                SoundManager.shared.playSound(LocalConstants.wrongAnswerSound)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.goToResultViewController()
                }
            }
        }
    }
    
    
    // MARK: - Private methods
    private func setupActions() {

        fiftyFiftyButton.addTarget(
            self,
            action: #selector(fiftyFiftyTapped),
            for: .touchUpInside
        )
        friendCallButton.addTarget(
            self,
            action: #selector(friendCallTapped),
            for: .touchUpInside
        )
        audienceAssistantButton.addTarget(
            self,
            action: #selector(audienceAssistantTapped),
            for: .touchUpInside
        )
        
        takeMoneyButton.addTarget(
            self,
            action: #selector(takeMoneyTapped),
            for: .touchUpInside
        )
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
    // MARK: - Navigation
    private func goToResultViewController() {
        let resultVC = ResultViewController()
        resultVC.setWinningAmount(currentWinningAmount)
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    private func goToAmountViewController(withQuestionIndex questionIndex: Int) {
        let resultVC = AmountViewController(currentQuestionIndex: questionIndex)
        self.navigationController?.pushViewController(resultVC, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
    func showFriendCallHint() {
        let hintView = FriendCallingСustomView(frame: CGRect(x: 0, y: 0, width: 500, height: 500 ))
        hintView.center = self.view.center
        self.view.addSubview(hintView)
        hintView.showHint()
    }
    
    // MARK: - Objc methods
    @objc private func fiftyFiftyTapped(_ sender: UIButton) {
        
        fiftyFiftyImageView.image = LocalConstants.fiftyFiftyUsedImage
        
        useFiftyFiftyTip()
        
    }
    
    private func useFiftyFiftyTip() {
        
        fiftyFiftyButton.isEnabled = false
        
        PersistenceManager.defaults.set(true, forKey: PersistenceManager.Keys.isFiftyFiftyUsed)
        
        var incorrectOptions = incorrectAnswers
        
        while incorrectOptions.count > 2 {
            incorrectOptions.remove(at: Int.random(in: 0..<incorrectOptions.count))
        }
        
        [buttonA, buttonB, buttonC, buttonD].forEach { button in
            if incorrectOptions.contains(where: { $0.htmlDecoded == button.answerTitle }) {
                button.answerLabel.text = ""
                button.prefixLabel.text = ""
            }
        }
    }
    
    @objc private func friendCallTapped() {
        
        friendCallButton.isEnabled = false
        
        PersistenceManager.defaults.set(true, forKey: PersistenceManager.Keys.isFriendCallUsed)
        
        friendCallImageView.image = LocalConstants.friendCallUsedImage
        
        showFriendCallHint()
    }
    
    @objc private func audienceAssistantTapped() {
        
        audienceAssistantButton.isEnabled = false
        
        PersistenceManager.defaults.set(true, forKey: PersistenceManager.Keys.isAudienceHelpUsed)
        
        let audienceHelpVC = AudienceHelpViewController()
        present(audienceHelpVC, animated: true)
        
        audienceAssistantImageView.image = LocalConstants.audienceHelpUsedImage
    }
    
    @objc private func takeMoneyTapped() {
        
        
        SoundManager.shared.playSound(LocalConstants.victoryMillionSound)
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
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        answersStackView.snp.makeConstraints { make in
            make.height.equalTo(250)
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
    
    static let friendIsCalling = UIImage(named: "FriendCalling")
    
    static let takeMoneyImage = UIImage(named: "monetization_on")
    
    static let numberOfSeconds = 30
    
    static let waitForResponseSound = "waitForResponse"
    static let victoryMillionSound = "victoryMillion"
    static let waitForInspectionSound = "waitForInspection"
    static let correctAnswerSound = "correctAnswer"
    static let wrongAnswerSound = "wrongAnswer"
 }
