//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Mikhail Ustyantsev on 18.02.2024.
//

import Foundation


enum PersistanceActionType {
    case add, remove
}


enum PersistenceManager {
    
    static let defaults = UserDefaults.standard
    
    enum Keys {
        static let isAudienceHelpUsed = "isAudienceHelpUsed"
    }

}
