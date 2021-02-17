//
//  PlayPauseButton.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

struct PlayPauseButton: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .foregroundColor(.green)
            .onTapGesture {
                if timerManager.timerMode == .running {
                    timerManager.pause()
                } else {
                    timerManager.start()
                }
            }
    }
}

struct TimerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButton(timerManager: TimerManager(session: testData[0]))
            .previewLayout(.fixed(width: 180, height: 180))
    }
}
