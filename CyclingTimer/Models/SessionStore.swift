//
//  SessionStore.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-02.
//

import Foundation

let testStore = SessionStore(sessions: testData)

class SessionStore: ObservableObject {
    
    @Published var sessions: [Session]
    
    init(sessions: [Session] = []) {
        self.sessions = sessions
    }
}
