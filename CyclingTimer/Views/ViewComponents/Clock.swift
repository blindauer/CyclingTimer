//
//  Clock.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

struct Clock: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack {
            Text(timerManager.setTimeRemainingTimeStamp)
                .font(.system(size: 80))
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        Clock(timerManager: TimerManager())
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
