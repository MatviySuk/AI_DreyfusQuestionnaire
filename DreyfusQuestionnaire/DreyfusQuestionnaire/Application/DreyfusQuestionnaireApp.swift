//
//  DreyfusQuestionnaireApp.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 05.03.2023.
//

import SwiftUI

@main
struct DreyfusQuestionnaireApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    private let container: DIContainer
    
    init() {
        let environment = AppEnvironment.bootstrap()

        self.container = environment.container
    }
    
    var body: some Scene {
        WindowGroup {
            BaseView(viewModel: .init(container: container))
                .onChange(of: scenePhase) { newValue in
                    switch newValue {
                    case .background:
                        container.services.questionnaireStore.save(questionnaire: container.appState[\.questionnaire])
                    default:
                        break
                    }
                }
        }
    }
}
