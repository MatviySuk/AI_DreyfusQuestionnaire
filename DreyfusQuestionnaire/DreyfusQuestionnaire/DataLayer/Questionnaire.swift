//
//  Questionnaire.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import Foundation

struct Questionnaire: Equatable, Identifiable {
    let id = UUID()
    
    private(set) var novice: Module
    private(set) var advancedBegineer: Module
    private(set) var competent: Module
    private(set) var proficient: Module
    private(set) var expert: Module
    
    static func == (lhs: Questionnaire, rhs: Questionnaire) -> Bool {
        lhs.novice == rhs.novice
        && lhs.advancedBegineer == rhs.advancedBegineer
        && lhs.competent == rhs.competent
        && lhs.proficient == rhs.proficient
        && lhs.expert == rhs.expert
    }
    
    func getQuestionsFor(_ module: QuestionnaireModule) -> Module {
        switch module {
        case .novice:
            return novice
        case .advancedBegineer:
            return advancedBegineer
        case .competent:
            return competent
        case .proficient:
            return proficient
        case .expert:
            return expert
        }
    }
    
    mutating func reset() {
        novice.reset()
        advancedBegineer.reset()
        competent.reset()
        proficient.reset()
        expert.reset()
    }
    
    func updated(_ module: Module) -> Questionnaire {
        var new = self
        
        switch module.type {
        case .novice:
            new.novice = module
        case .advancedBegineer:
            new.advancedBegineer = module
        case .competent:
            new.competent = module
        case .proficient:
            new.proficient = module
        case .expert:
            new.expert = module
        }
        
        return new
    }
}

extension Questionnaire: Codable {
    
}

extension Questionnaire {
    init() {
        self.novice = Module(questions: [
            Question(title: "Переживаєте за успіх в роботі", highAnswer: "Cильно", goodAnswer: "Не дуже", lowAnswer: "Спокійний"),
            Question(title: "Прагнете досягти швидко результату", highAnswer: "Дуже", goodAnswer: "Якомога швидше", lowAnswer: "Поступово"),
            Question(title: "Легко попадаєте в тупик при проблемах в роботі", highAnswer: "Неодмінно", goodAnswer: "Поступово", lowAnswer: "Зрідка"),
            Question(title: "Чи потрібен чіткий алгоритм для вирішення задач", highAnswer: "Так", goodAnswer: "В окремих випадках", lowAnswer: "Не потрібен")
        ], type: .novice)
        
        self.advancedBegineer = Module(questions: [
            Question(title: "Чи використовуєте власний досвід при вирішенні задач", highAnswer: "Зрідка", goodAnswer: "Частково", lowAnswer: "Ні"),
            Question(title: "Чи користуєтесь фіксованими правилами  для вирішення задач", highAnswer: "Не потрібні", goodAnswer: "В окремих випадках", lowAnswer: "Так"),
            Question(title: "Чи відчуваєте ви загальний контекст вирішення задачі", highAnswer: "В окремих випадках", goodAnswer: "Частково", lowAnswer: "Так")
        ], type: .advancedBegineer)

        self.competent = Module(questions: [
            Question(title: "Чи можете ви побудувати модель вирішуваної задачі", highAnswer: "Так", goodAnswer: "Не повністю", lowAnswer: "В окремих випадках"),
            Question(title: "Чи вистачає вам ініціативи при вирішенні задач", highAnswer: "Так", goodAnswer: "Зрідка", lowAnswer: "Потрібне натхнення"),
            Question(title: "Чи можете вирішувати проблеми, з якими ще не стикались", highAnswer: "Ні", goodAnswer: "В окремих випадках", lowAnswer: "Так")
        ], type: .competent)
        
        self.proficient = Module(questions: [
            Question(title: "Чи  необхідний вам весь контекст задачі", highAnswer: "Так", goodAnswer: "В окремих деталях", lowAnswer: "В загальному"),
            Question(title: "Чи переглядаєте ви свої наміри до вирішення задачі", highAnswer: "Так", goodAnswer: "Зрідка", lowAnswer: "Коли є потреба"),
            Question(title: "Чи здатні ви навчатися у інших", highAnswer: "Так", goodAnswer: "Зрідка", lowAnswer: "Коли є потреба")
        ], type: .proficient)
        
        self.expert = Module(questions: [
            Question(title: "Чи обираєте ви нові методи своєї роботи", highAnswer: "Так", goodAnswer: "Вибірково", lowAnswer: "Вистачає досвіду"),
            Question(title: "Чи допомагає власна інтуїція при вирішенні задач", highAnswer: "Так", goodAnswer: "Частково", lowAnswer: "При емоційному напруженні"),
            Question(title: "Чи застовуєте рішення задач за аналогією", highAnswer: "Часто", goodAnswer: "Зрідка", lowAnswer: "Тільки власний варіант")
        ], type: .expert)
    }
}
