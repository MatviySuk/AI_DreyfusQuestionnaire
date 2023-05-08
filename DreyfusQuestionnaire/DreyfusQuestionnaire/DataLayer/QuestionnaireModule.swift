//
//  QuestionnaireModule.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import Foundation

enum QuestionnaireModule: String, CaseIterable, Codable {
    case novice
    case advancedBegineer
    case competent
    case proficient
    case expert
    
    var title: String {
        switch self {
        case .novice:
            return "Новачок"
        case .advancedBegineer:
            return "Просунутий початківець"
        case .competent:
            return "Компетентний"
        case .proficient:
            return "Досвідчений"
        case .expert:
            return "Експерт"
        }
    }
}
