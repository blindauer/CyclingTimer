//
//  TimerButtonView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

struct TimerButtonView: View {
    @ObservedObject var timerManager = TimerManager.shared
    
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
        TimerButtonView()
            .previewLayout(.fixed(width: 180, height: 180))
    }
}
