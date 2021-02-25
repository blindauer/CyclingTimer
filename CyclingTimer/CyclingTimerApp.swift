//
//  CyclingTimerApp.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-25.
//

import SwiftUI

@main
struct CyclingTimerApp: App {
    @ObservedObject private var data = SessionData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SessionListView(sessions: $data.sessions) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
