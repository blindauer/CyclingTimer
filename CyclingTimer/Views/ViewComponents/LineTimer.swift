//
//  LineTimer.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

private enum AnimatedCirclePosition {
    case inner
    case middle
    case outer
}

struct LineTimer: View {
    @ObservedObject var timerManager: TimerManager
    
    let sessionLineWidth: CGFloat = 10.0
    let setLineWidth: CGFloat = 30.0
    let setPadding: CGFloat = 80.0
    let sessionPadding: CGFloat = 20.0
    
    var animatedCircles: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 1.0, lineCap: .round, lineJoin: .round))
                .padding(timerManager.timerState == .running ? startPadding(position: .inner) : endPadding(position: .inner))
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
                .padding(timerManager.timerState == .running ? startPadding(position: .middle) : endPadding(position: .middle))
                .opacity(0.75)
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 1.0, lineCap: .round, lineJoin: .round))
                .padding(timerManager.timerState == .running ? startPadding(position: .outer) : endPadding(position: .outer))
        }
        .foregroundColor(timerManager.setColor)
        .animation(Animation.easeInOut(duration: 1).repeat(while: timerManager.timerState == .running))
    }
    
    var setBackgroundCircle: some View {
        Circle()
            .stroke(lineWidth: setLineWidth)
            .opacity(0.3)
            .foregroundColor(timerManager.setColor)
            .padding(setPadding)
    }
    
    var setProgressCircle: some View {
        Circle()
            .trim(from: 0.0, to: CGFloat(timerManager.setProgress))
            .stroke(style: StrokeStyle(lineWidth: setLineWidth, lineCap: .round, lineJoin: .round))
            .foregroundColor(timerManager.setColor)
            .rotationEffect(Angle(degrees: 270.0))
            .animation(timerManager.animation ? .linear : .none)
            .padding(setPadding)
    }
    
    var sessionBackgroundCircle: some View {
        Circle()
            .stroke(lineWidth: sessionLineWidth)
            .opacity(0.3)
            .foregroundColor(timerManager.setColor)
            .padding(sessionPadding)
    }
    
    var sessionProgressCircle: some View {
        Circle()
            .trim(from: 0.0, to: CGFloat(timerManager.sessionProgress))
            .stroke(style: StrokeStyle(lineWidth: sessionLineWidth, lineCap: .round, lineJoin: .round))
            .foregroundColor(timerManager.setColor)
            .rotationEffect(Angle(degrees: 270.0))
            .animation(timerManager.animation ? .linear : .none)
            .padding(sessionPadding)
    }
    
    var body: some View {
        ZStack {
            animatedCircles
            sessionBackgroundCircle
            sessionProgressCircle
            setBackgroundCircle
            setProgressCircle
        }
    }
    
    private func startPadding(position: AnimatedCirclePosition) -> CGFloat {
        let startPadding = sessionPadding - sessionLineWidth / 2 + sessionLineWidth
        switch position {
        case .inner:
            return startPadding + 0.0
        case .middle:
            return startPadding + 10.0
        case .outer:
            return startPadding + 20.0
        }
    }
    
    private func endPadding(position: AnimatedCirclePosition) -> CGFloat {
        return setPadding - setLineWidth / 2
//        let endPadding = setPadding - setLineWidth / 2
//        switch position {
//        case .inner:
//            return endPadding - 0.0
//        case .middle:
//            return endPadding - 0.0
//        case .outer:
//            return endPadding - 0.0
//        }
    }
}

struct CircularBarView_Previews: PreviewProvider {
    static var previews: some View {
        LineTimer(timerManager: TimerManager())
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
