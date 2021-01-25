//
//  CyclingTimerApp.swift
//  CyclingTimer WatchKit Extension
//
//  Created by Maria Civilis on 2021-01-25.
//

import SwiftUI

@main
struct CyclingTimerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
