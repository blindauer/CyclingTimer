//
//  ClockView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

struct ClockView: View {
    @ObservedObject var timerManager = TimerManager.shared
    
    var body: some View {
        Text(secondsToMinutesAndSeconds(seconds: timerManager.timeRemaining))
            .font(.system(size: 80))
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
