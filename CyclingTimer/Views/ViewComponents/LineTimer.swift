//
//  LineTimer.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

struct LineTimer: View {
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 40.0)
                .opacity(0.3)
                .foregroundColor(.green)
            Circle()
                .trim(from: 0.0, to: CGFloat(timerManager.progress))
                .stroke(style: StrokeStyle(lineWidth: 40.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.green)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut)
        }
        .padding(40.0)
    }
}

struct CircularBarView_Previews: PreviewProvider {
    static var previews: some View {
        LineTimer(timerManager: TimerManager(session: testData[0]))
            .previewLayout(.fixed(width: 400, height: 400))
    }
}