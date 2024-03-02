import Foundation

struct Award {
    let questionIndex: Int
    let amount: Int
    let guaranteed: Bool
}

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
    
    let awards: [Award] = [
        
        Award(questionIndex: 1, amount: 100, guaranteed: false),
        Award(questionIndex: 2, amount: 200, guaranteed: false),
        Award(questionIndex: 3, amount: 300, guaranteed: false),
        Award(questionIndex: 4, amount: 500, guaranteed: false),
        Award(questionIndex: 5, amount: 1000, guaranteed: true),
        Award(questionIndex: 6, amount: 2000, guaranteed: false),
        Award(questionIndex: 7, amount: 4000, guaranteed: false),
        Award(questionIndex: 8, amount: 8000, guaranteed: false),
        Award(questionIndex: 9, amount: 16000, guaranteed: false),
        Award(questionIndex: 10, amount: 32000, guaranteed: true),
        Award(questionIndex: 11, amount: 64000, guaranteed: false),
        Award(questionIndex: 12, amount: 125000, guaranteed: false),
        Award(questionIndex: 13, amount: 250000, guaranteed: false),
        Award(questionIndex: 14, amount: 500000, guaranteed: false),
        Award(questionIndex: 15, amount: 1000000, guaranteed: true)
    ]
    
    
    private init() {}
    
    func moveToNextQuestion() {
        currentQuestionIndex += 1
        if let award = awards.first(where: { $0.questionIndex == currentQuestionIndex && $0.guaranteed }) {
            guaranteedPrize = award.amount
        }
    }
        func useFiftyFifty() {
            fiftyFiftyUsed = true
        }
        
        func resetGame() {
            currentQuestionIndex = 1
              fiftyFiftyUsed = false
              guaranteedPrize = 0
              lastCorrectAnswerIndex = nil
        }
        
        func getCurrentPrize() -> Int {
            return awards.first { $0.questionIndex == currentQuestionIndex }?.amount ?? 0
        }
        
        func getGuaranteedPrize() -> Int {
            return guaranteedPrize
        }
    }

