//
//  QuestionnaireViewModel.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import Combine

final class QuestionnaireViewModel: ViewModel {
    @Published var questionnaire: Questionnaire
    
    override init(container: DIContainer) {
        self.questionnaire = container.appState[\.questionnaire]
        
        super.init(container: container)
        
        cancelBag.collect {
            $questionnaire
                .sink { container.appState[\.questionnaire] = $0 }
            
            container.appState
                .updates(for: \.questionnaire)
                .weakAssign(to: \.questionnaire, on: self)
        }
    }
    
    func moduleFor(_ moduleType: QuestionnaireModule) -> Module {
        questionnaire.getQuestionsFor(moduleType)
    }
    
    func restartQuestionnaire() {
        questionnaire.reset()
    }
}
