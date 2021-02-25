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
    /// Indicates current timer state
    @Published var timerState: TimerState = .initial
    /// Indicates the timer progress on the current set
    @Published var progress: Double = .zero
    /// Used to indicate to parent whether progress changes should be animated (i.e. when switching to new set animation is disabled)
    @Published var animation: Bool = true
    /// Primary time stamp used to show a clock as each set is running
    @Published var timeStamp: String = TimerManager.timeStamp(time: 0.0)
    /// Time stamp  used to show total session elapsed time
    @Published var elapsedTimeStamp: String = TimerManager.timeStamp(time: 0.0)
    /// Time stamp  used to show total session remaining time
    @Published var remainingTimeStamp: String = TimerManager.timeStamp(time: 0.0)

    private var segmentIndex: Int = 0
    private var setIndex: Int = 0
    private var timer = Timer()
    private var timeElapsed: Double = .zero
    private var session: Session?
    private var totalTimeElapsed: Double = .zero
    private var totalTimeRemaining: Double  = .zero
   
    /// A closure that is executed when a new set begins.
    var setChangedAction: (() -> Void)? // FIX ME: not sure I am going to use this yet
    
    /**
     Initializes timer  with a new session.
     - Parameters:
         - session: Session to run.
     */
    func initialize(with newSession: Session) {
        timerState = .initial
        progress = .zero
        animation = true
        elapsedTimeStamp = TimerManager.timeStamp(time: 0.0)
        segmentIndex = 0
        setIndex = 0
        timer = Timer()
        timeElapsed = .zero
        totalTimeElapsed = .zero
        session = newSession
        totalTimeRemaining = newSession.duration
        remainingTimeStamp = TimerManager.timeStamp(time: newSession.duration)
        timeStamp = TimerManager.timeStamp(time: newSession.segments[segmentIndex].sets[setIndex].duration)
    }
    
    func start() {
        timerState = .running
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
        if Int(timeElapsed) < Int(session.segments[segmentIndex].sets[setIndex].duration) {
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
        timeElapsed += 0.1
        totalTimeElapsed += 0.1
        totalTimeRemaining += 0.1
        elapsedTimeStamp = TimerManager.timeStamp(time: totalTimeElapsed)
        remainingTimeStamp = TimerManager.timeStamp(time: totalTimeRemaining)
        timeStamp = TimerManager.timeStamp(time: duration - timeElapsed)
        progress = timeElapsed / duration
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
        progress = 0
        timeElapsed = 0
        timer.invalidate()
        setChangedAction?()
        if updateMode == .set {
            return
        }
        // Full reset
        segmentIndex = 0
        setIndex = 0
        let time = session.segments[segmentIndex].sets[setIndex].duration - timeElapsed
        timeStamp = TimerManager.timeStamp(time: time)
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
    
