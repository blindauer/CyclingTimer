//
//  LineTimer.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

struct LineTimer: View {
    @ObservedObject var timerManager: TimerManager
    
    private let size: CGFloat = 300
    private let lineWIdth: CGFloat = 30
    
    var animatedCircle: some View {
        Circle()
            .fill(RadialGradient(gradient: Gradient(colors: [Color.white, timerManager.setColor]), center: .center, startRadius: 0, endRadius: lineWIdth / 3))
            .frame(width: lineWIdth / 1.5, height: lineWIdth / 1.5)
            .foregroundColor(timerManager.setColor)
            .offset(y: (size + lineWIdth * 2) / -2 - 1)
            .rotationEffect(.degrees(timerManager.timerState == .running ? 0 : -360))
            .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
    }
    
    var animationPathCircle: some View {
        Circle()
        .stroke(lineWidth: 3.0)
        .foregroundColor(timerManager.setColor)
        .frame(width: size + lineWIdth * 2, height: size + lineWIdth * 2)
    }
    
    var backgroundCircle: some View {
        Circle()
            .stroke(lineWidth: lineWIdth)
            .opacity(0.3)
            .foregroundColor(timerManager.setColor)
            .frame(width: size, height: size)
    }
    
    var setProgressCircle: some View {
        Circle()
            .trim(from: 0.0, to: CGFloat(timerManager.setProgress))
            .stroke(style: StrokeStyle(lineWidth: lineWIdth, lineCap: .round, lineJoin: .round))
            .foregroundColor(timerManager.setColor)
            .rotationEffect(Angle(degrees: 270.0))
            .animation(.linear)
            .frame(width: size, height: size)
    }
    
    var sessionProgressCircle: some View {
        Circle()
            .trim(from: 0.0, to: CGFloat(timerManager.sessionProgress))
            .stroke(style: StrokeStyle(lineWidth: lineWIdth / 3, lineCap: .round, lineJoin: .round))
            .foregroundColor(timerManager.setColor)
            .rotationEffect(Angle(degrees: 270.0))
            .animation(timerManager.animation ? .linear : .none)
            .frame(width: size + lineWIdth * 2, height: size + lineWIdth * 2)
    }
    
    var body: some View {
        ZStack {
            animationPathCircle
            backgroundCircle
            setProgressCircle
            sessionProgressCircle
            animatedCircle
        }
    }
}

struct CircularBarView_Previews: PreviewProvider {
    static var previews: some View {
        LineTimer(timerManager: TimerManager())
    }
}
