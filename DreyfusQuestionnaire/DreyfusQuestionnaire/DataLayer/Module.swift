//
//  Module.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import Foundation

struct Module: Equatable {
    var questions: [Question]
    let type: QuestionnaireModule
    
    static func == (lhs: Module, rhs: Module) -> Bool {
        lhs.questions == rhs.questions
        &&
        lhs.type == rhs.type
    }
    
    func getTotalMark() -> Int {
        questions.reduce(.zero, { $0 + ($1.mark?.rawValue ?? .zero) })
    }
    
    mutating func reset() {
        questions.indices.forEach { index in
            questions[index].mark = nil
        }
    }
}

extension Module: Codable {
    
}

extension Module {
    static var clear: Module {
        Module(questions: [
            Question(title: "", highAnswer: "", goodAnswer: "", lowAnswer: ""),
        ], type: .novice)
    }
    
    static var mock: Module {
        Module(questions: [
            Question(title: "Чи обираєте ви нові методи своєї роботи", highAnswer: "Так", goodAnswer: "Вибірково", lowAnswer: "Вистачає досвіду", mark: .low),
            Question(title: "Чи допомагає власна інтуїція при вирішенні задач", highAnswer: "Так", goodAnswer: "Частково", lowAnswer: "При емоційному напруженні", mark: .good),
            Question(title: "Чи застовуєте рішення задач за аналогією", highAnswer: "Часто", goodAnswer: "Зрідка", lowAnswer: "Тільки власний варіант", mark: .high)
        ], type: .expert)
    }
}
