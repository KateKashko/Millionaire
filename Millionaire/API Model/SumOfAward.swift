//
//  SumOfAward.swift
//  Millionaire
//
//  Created by Павел Широкий on 26.02.2024.
//

import Foundation

struct SumOfAward {
    
    var rawNumber = 0
    
    let sumOfAward = [
        Amount(num: 15, award: 1000000, canTake: true),
        Amount(num: 14, award: 500000, canTake: false),
        Amount(num: 13, award: 250000, canTake: false),
        Amount(num: 12, award: 125000, canTake: false),
        Amount(num: 11, award: 64000, canTake: false),
        Amount(num: 10, award: 32000, canTake: true),
        Amount(num: 9, award: 16000, canTake: false),
        Amount(num: 8, award: 8000, canTake: false),
        Amount(num: 7, award: 4000, canTake: false),
        Amount(num: 6, award: 2000, canTake: false),
        Amount(num: 5, award: 1000, canTake: true),
        Amount(num: 4, award: 500, canTake: false),
        Amount(num: 3, award: 300, canTake: false),
        Amount(num: 2, award: 200, canTake: false),
        Amount(num: 1, award: 100, canTake: false)
    ]
    
    mutating func checkRawNumber() -> Int {
        if rawNumber < 15 {
            rawNumber += 1
        }
        return rawNumber
    }
    
    func getNumberOfAward() -> Int {
        return sumOfAward[rawNumber].num
    }
    
    func getSumOfAward() -> Int {
        return sumOfAward[rawNumber].award
    }
    
    func getCanTakeStatus() -> Bool {
        return sumOfAward[rawNumber].canTake
    }
}
