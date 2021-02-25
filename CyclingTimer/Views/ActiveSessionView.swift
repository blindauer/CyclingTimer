//
//  SessionDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct SessionProgressViewStyle: ProgressViewStyle {
    var color: Color
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .foregroundColor(color)
//            .shadow(color: color,
//                    radius: 4.0, x: 1.0, y: 2.0)
    }
}

struct ActiveSessionView: View {
    @Binding var session: Session
    @StateObject var timerManager = TimerManager()
    
    var body: some View {
        VStack {
            HStack {
                Label(timerManager.sessionTimeElapsedTimeStamp, systemImage: "hourglass.bottomhalf.fill")
                Spacer()
                Label(timerManager.sessionTimeRemainingTimeStamp, systemImage: "hourglass.tophalf.fill")
            }
            ProgressView(value: timerManager.sessionProgress)
                .progressViewStyle(SessionProgressViewStyle(color: timerManager.setColor))
            VStack {
                Clock(timerManager: timerManager)
                ZStack {
                    PlayPauseButton(timerManager: timerManager)
                    LineTimer(timerManager: timerManager)
                }
            }
        }
        .onAppear {
            timerManager.initialize(with: session)
            timerManager.start()
        }
        .onDisappear {
            timerManager.pause()
        }
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActiveSessionView(session: .constant(Session.data[0]))
    }
}
