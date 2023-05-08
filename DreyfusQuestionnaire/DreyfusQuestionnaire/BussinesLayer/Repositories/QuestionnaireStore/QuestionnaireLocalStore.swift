//
//  QuestionnaireStore.swift
//  DreyfusQuestionnaire
//
//  Created by Matviy Suk on 06.03.2023.
//

import Foundation

protocol QuestionnaireLocalStore {
    func readQuestionnaire() -> Result<Questionnaire, Error>
    func save(questionnaire: Questionnaire) -> Result<Void, Error>
}
