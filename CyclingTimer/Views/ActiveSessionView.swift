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
    
    private var description: some View {
        Text(timerManager.setDescription)
            .font(.system(size: 40))
            .blur(radius: timerManager.timerState == .paused ? 10 : 0)
    }
    
    private var sessionTimeRemaining: some View {
        Text(timerManager.sessionTimeRemainingTimeStamp)
            .font(.system(size: 40))
            .blur(radius: timerManager.timerState == .paused ? 10 : 0)
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
    
    private var timerView: some View {
        VStack {
            ZStack {
                LineTimer(timerManager: timerManager)
                    .blur(radius: timerManager.timerState == .paused ? 10 : 0)
                if timerManager.timerState == .paused {
                    playButtonOverlay
                }
            }
        }
        .contentShape(Rectangle())
        .ignoresSafeArea()
        .onTapGesture {
            timerManager.pause()
        }
    }
    
    private var effort: some View {
        EffortView(effort: timerManager.setEffort)
            .blur(radius: timerManager.timerState == .paused ? 10 : 0)
    }
    
    var body: some View {
        ZStack {
            timerView
            VStack {
                HStack {
                    description
                    effort
                }
                Spacer()
                sessionTimeRemaining
            }
        }
        .onAppear {
            timerManager.initialize(with: session)
            timerManager.start()
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            timerManager.pause()
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActiveSessionView(session: .constant(Session.data[0]))
    }
}


