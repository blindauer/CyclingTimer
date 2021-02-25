//
//  SessionDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct ActiveSessionView: View {
    @Binding var session: Session
    @StateObject var timerManager = TimerManager()
    
    var body: some View {
        VStack {
            HStack {
                Label(timerManager.elapsedTimeStamp, systemImage: "hourglass.bottomhalf.fill")
                Spacer()
                Label(timerManager.remainingTimeStamp, systemImage: "hourglass.tophalf.fill")
            }
            ProgressView(value: 5, total: 15)
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
