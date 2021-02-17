//
//  SessionDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct SessionView: View {
    
    private var timerManager: TimerManager
    
    init(session: Session) {
        self.timerManager = TimerManager(session: session)
    }
    
    
    var body: some View {
        VStack {
            Clock(timerManager: timerManager)
            Spacer()
            ZStack {
                PlayPauseButton(timerManager: timerManager)
                LineTimer(timerManager: timerManager)
            }
            Spacer()
        }
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(session: testStore.sessions[0])
    }
}
