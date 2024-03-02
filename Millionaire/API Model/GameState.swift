import Foundation

class GameState {
    
    static let shared = GameState()
    
    var currentQuestionIndex: Int = 1 {
        didSet {
            // Проверяем, является ли текущий выигрыш несгораемой суммой
            let currentAward = sumOfAward.sumOfAward.first { $0.num == currentQuestionIndex }
            if currentAward?.canTake == true {
                guaranteedPrize = currentAward!.award
            }
        }
    }
    var fiftyFiftyUsed: Bool = false
    var sumOfAward = SumOfAward()
    var guaranteedPrize: Int = 0 // Последний выигрыш, который является несгораемой суммой
    var lastCorrectAnswerIndex: Int? // Индекс последнего правильного ответа
    
    private init() {}
    
    func moveToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func useFiftyFifty() {
        fiftyFiftyUsed = true
    }
    
    func resetGame() {
        currentQuestionIndex = 1
        fiftyFiftyUsed = false
        guaranteedPrize = 0
        lastCorrectAnswerIndex = nil
        sumOfAward = SumOfAward()
    }
    
    func getCurrentPrize() -> Int {
        return sumOfAward.getSumOfAward()
    }

    func getGuaranteedPrize() -> Int {
        return guaranteedPrize
    }
}
