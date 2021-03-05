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
    
    private var clock: some View {
        Text(timerManager.setTimeRemainingTimeStamp)
            .font(.system(size: 80))
    }
    
    private var playButtonOverlay: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.5)
                .ignoresSafeArea()
            Image(systemName: "play.circle.fill")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
                .padding(40)
                .opacity(0.4)
                .padding(90)
                .colorInvert()
                .onTapGesture {
                    timerManager.start()
                }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                clock
                LineTimer(timerManager: timerManager)
            }
            .blur(radius: timerManager.timerState == .paused ? 10 : 0)
            if timerManager.timerState == .paused {
                playButtonOverlay
            }
        }
        .padding(20.0)
        .contentShape(Rectangle())
        .onTapGesture {
            timerManager.pause()
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
