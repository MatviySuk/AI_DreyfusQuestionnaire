//
//  UserDefaultsQuestionnaireStore.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 06.03.2023.
//

import Foundation

struct UserDefaultsQuestionnaireStore: QuestionnaireLocalStore {
    let defaults: UserDefaults = .standard
    
    let appState: Store<AppState>
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
        
    func readQuestionnaire() -> Result<Questionnaire, Error> {
        do {
            guard let user = appState[\.auth].user,
                  let anyData = defaults.object(forKey: user.name),
                  let savedData = anyData as? Data else {
                return .failure(StringError(value: "Data Not Found!"))
            }
            
            
            let loaded = try JSONDecoder().decode(Questionnaire.self, from: savedData)
            
            return .success(loaded)
        } catch {
            return .failure(error)
        }
    }
    
    func save(questionnaire: Questionnaire) -> Result<Void, Error> {
        do {
            guard let user = appState[\.auth].user else {
                return .failure(StringError(value: "Data Not Found!"))
            }
            
            let encoded = try JSONEncoder().encode(questionnaire)
            
            defaults.set(encoded, forKey: user.name)
            
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
