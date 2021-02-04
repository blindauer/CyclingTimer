//
//  CyclingTimerApp.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-25.
//

import SwiftUI

@main
struct CyclingTimerApp: App {
    @StateObject private var store = testStore
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
