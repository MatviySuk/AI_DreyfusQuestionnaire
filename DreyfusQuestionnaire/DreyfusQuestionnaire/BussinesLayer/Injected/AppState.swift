//
//  AppState.swift
//
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var auth = Auth()
    var questionnaire = Questionnaire()
}

extension AppState {
    struct Auth: Equatable {
        var user: User? = nil
        var isAuthorized: Bool {
            user != nil
        }
        
        static var mock: Auth {
            Auth(user: User(name: "Matviy"))
        }
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.questionnaire == rhs.questionnaire &&
        lhs.auth == rhs.auth
    
}

extension AppState {
    static var preview: AppState {
        AppState()
    }
}
