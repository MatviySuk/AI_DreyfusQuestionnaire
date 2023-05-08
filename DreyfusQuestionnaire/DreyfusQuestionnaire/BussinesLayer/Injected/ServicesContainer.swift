//
//  DIContainer.Interactors.swift
//

struct Services {
    let authService: AuthService
    let questionnaireStore: QuestionnaireLocalStore
    
    init(
        authService: AuthService,
        questionnaireStore: QuestionnaireLocalStore
    ) {
        self.authService = authService
        self.questionnaireStore = questionnaireStore
    }
    
    static var stub: Self {
        let appState = Store<AppState>(AppState())
        
        return .init(
            authService: LocalAuthService(appState: appState),
            questionnaireStore: UserDefaultsQuestionnaireStore(appState: appState)
        )
    }
}
