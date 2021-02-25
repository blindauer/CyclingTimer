//
//  TimerManager.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import Foundation
import SwiftUI

enum TimerState {
    case initial
    case running
    case paused
}

enum UpdateMode {
    case set
    case session
}
/// Keeps time for a session sets and supplies time conversions
class TimerManager: ObservableObject {
    /// Used to indicate to parent whether progress changes should be animated (i.e. when switching to new set animation is disabled)
    @Published var animation: Bool = true
    /// Indicates current timer state
    @Published var timerState: TimerState = .initial
    /// Indicates the timer progress on the current set
    @Published var setProgress: Double = .zero
    /// Time stamp  used to show remaining set time
    @Published var setTimeRemainingTimeStamp: String = TimerManager.timeStamp(time: 0.0)
    /// Current session that the timer is running
    private var session: Session?
    /// Time stamp  used to show total session elapsed time
    @Published var sessionTimeElapsedTimeStamp: String = TimerManager.timeStamp(time: 0.0)
    /// Time stamp  used to show total session remaining time
    @Published var sessionTimeRemainingTimeStamp: String = TimerManager.timeStamp(time: 0.0)
    /// Indicates the overall  progress of the current session
    @Published var sessionProgress: Double = .zero
    /// Color of the currently running set
    @Published var setColor: Color = Color.accentColor
    
    private var segmentIndex: Int = 0
    private var setIndex: Int = 0
    private var timer = Timer()
    private var setTimeElapsed: Double = .zero
    private var sessionTimeElapsed: Double = .zero
   
    /// A closure that is executed when a new set begins.
    var setChangedAction: (() -> Void)? // FIX ME: not sure I am going to use this yet
    
    /**
     Initializes timer  with a new session.
     - Parameters:
         - session: Session to run.
     */
    func initialize(with newSession: Session) {
        timerState = .initial
        setProgress = .zero
        sessionProgress = .zero
        animation = true
        sessionTimeElapsedTimeStamp = TimerManager.timeStamp(time: 0.0)
        segmentIndex = 0
        setIndex = 0
        timer = Timer()
        setTimeElapsed = .zero
        sessionTimeElapsed = .zero
        session = newSession
        sessionTimeRemainingTimeStamp = TimerManager.timeStamp(time: newSession.duration)
        setTimeRemainingTimeStamp = TimerManager.timeStamp(time: newSession.segments[segmentIndex].sets[setIndex].duration)
        setColor = newSession.segments[segmentIndex].sets[0].color
    }
    
    func start() {
        timerState = .running
        if let color = session?.segments[segmentIndex].sets[setIndex].color {
            setColor = color
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.timerFired()
        })
    }
    
    /// Pause the timer.
    func pause() {
        timerState = .paused
        timer.invalidate()
    }
    
    private func timerFired() {
        guard let session = session else {
            fatalError("Session has not been set")
        }
        if Int(setTimeElapsed) < Int(session.segments[segmentIndex].sets[setIndex].duration) {
            updateProgress()
        } else {
            nextSetOrFinish()
        }
    }
    
    private func updateProgress() {
        guard let session = session else {
            fatalError("Session has not been set")
        }
        animation = true
        let duration = session.segments[segmentIndex].sets[setIndex].duration
        setTimeElapsed += 0.1
        sessionTimeElapsed += 0.1
        sessionTimeElapsedTimeStamp = TimerManager.timeStamp(time: sessionTimeElapsed)
        sessionTimeRemainingTimeStamp = TimerManager.timeStamp(time: session.duration - sessionTimeElapsed)
        setTimeRemainingTimeStamp = TimerManager.timeStamp(time: duration - setTimeElapsed)
        setProgress = setTimeElapsed / duration
        sessionProgress = sessionTimeElapsed / session.duration
    }
    
    private func nextSetOrFinish() {
        guard let session = session else {
            fatalError("Session has not been set")
        }
        animation = false
        let lastSegment = session.segments.count - 1
        let lastSet = session.segments[segmentIndex].sets.count - 1
        
        if setIndex == lastSet && segmentIndex == lastSegment {
            updateTimer(updateMode: .session)
            return
        }
        updateTimer(updateMode: .set)
        if setIndex == lastSet  {
            setIndex = 0
            segmentIndex += 1
        } else {
            setIndex += 1
        }
        start()
    }
    
    private func updateTimer(updateMode: UpdateMode) {
        guard let session = session else {
            fatalError("Session has not been set")

        }
        timerState = .initial
        setProgress = 0
        setTimeElapsed = 0
        timer.invalidate()
        setChangedAction?()
        if updateMode == .set {
            return
        }
        // Full reset
        segmentIndex = 0
        setIndex = 0
        let time = session.segments[segmentIndex].sets[setIndex].duration - setTimeElapsed
        setTimeRemainingTimeStamp = TimerManager.timeStamp(time: time)
    }
    
    static func timeStamp(time: Double) -> String {
        let timeInSeconds = Int(time)
        let minutes = "\((timeInSeconds % 3600) / 60)"
        let seconds = "\((timeInSeconds % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        return "\(minuteStamp) : \(secondStamp)"
    }
}
    
