//
//  Question.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import Foundation

struct Question: Equatable, Hashable {
    let title: String
    
    private let highAnswer: String
    private let goodAnswer: String
    private let lowAnswer: String
    
    var mark: Mark? = nil
    
    init(title: String, highAnswer: String, goodAnswer: String, lowAnswer: String, mark: Mark? = nil) {
        self.title = title
        self.highAnswer = highAnswer
        self.goodAnswer = goodAnswer
        self.lowAnswer = lowAnswer
        self.mark = mark
    }
    
    func getAnswerFor(_ mark: Mark) -> String {
        switch mark {
        case .high:
            return highAnswer
        case .good:
            return goodAnswer
        case .low:
            return lowAnswer
        }
    }
}

extension Question: Codable {
    
}
