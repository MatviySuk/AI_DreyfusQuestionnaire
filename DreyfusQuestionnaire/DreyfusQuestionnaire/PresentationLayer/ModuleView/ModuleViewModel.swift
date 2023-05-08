//
//  ModuleViewModel.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import Combine

final class ModuleViewModel: ViewModel {
    @Published var module: Module
    var isFinished: Bool {
        !module.questions.map { $0.mark }.contains(nil)
    }
    
    init(container: DIContainer, module: Module) {
        self.module = module
        
        super.init(container: container)
                
        cancelBag.collect {
            $module
                .sink { module in
                    container.appState.bulkUpdate {
                        $0.questionnaire = $0.questionnaire.updated(module)
                    }
                }
            
            container.appState
                .updates(for: \.questionnaire)
                .map { $0.getQuestionsFor(module.type) }
                .weakAssign(to: \.module, on: self)
        }
    }
    
    func restartModule() {
        module.reset()
    }
}
