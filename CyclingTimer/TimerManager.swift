//
//  TimerManager.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import Foundation
import SwiftUI

enum TimerMode {
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
    
    @Published var timerMode: TimerMode = .initial
    @Published var timeStamp: String
    @Published var progress: Double = .zero
    @Published var animation: Bool = true
    @Published var elapsedTimeStamp: String = TimerManager.timeStamp(time: 0.0)
    @Published var remainingTimeStamp: String
    /// A closure that is executed when a new set begins.
    var setChangedAction: (() -> Void)? // FIX ME: not sure I am going to use this yet
    private var segmentIndex: Int = 0
    private var setIndex: Int = 0
    private var timer = Timer()
    private var timeElapsed: Double = .zero
    private var session: Session
    private var totalTimeElapsed: Double = .zero
    private var totalTimeRemaining: Double
    
    /**
     Initialize a new timer.  Initializing a timer with no sesion creates a timer with with empty session that has no sets and zero duration.
     Use `start()` to start the timer.
     
     - Parameters:
        - session: The session that the time will run set by set.
     */
    init(session: Session = Session()) {
        self.session = session
        self.totalTimeRemaining = session.duration
        self.remainingTimeStamp = TimerManager.timeStamp(time: session.duration)
        self.timeStamp = TimerManager.timeStamp(time: session.segments[segmentIndex].sets[setIndex].duration)
    }
    
    /// Start the timer.
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.timerFired()
        })
    }
    
    /// Pause the timer.
    func pause() {
        timerMode = .paused
        timer.invalidate()
    }
    
    /**
     Reset the timer with a new session.
     
     - Parameters:
         - session: Session to run.
     */
    func reset(session newSession: Session) {
        timerMode = .initial
        progress = .zero
        animation = true
        elapsedTimeStamp = TimerManager.timeStamp(time: 0.0)
        segmentIndex = 0
        setIndex = 0
        timer = Timer()
        timeElapsed = .zero
        totalTimeElapsed = .zero
        session = newSession
        totalTimeRemaining = session.duration
        remainingTimeStamp = TimerManager.timeStamp(time: session.duration)
        timeStamp = TimerManager.timeStamp(time: session.segments[segmentIndex].sets[setIndex].duration)
    }
    
    private func timerFired() {
        if Int(timeElapsed) < Int(session.segments[segmentIndex].sets[setIndex].duration) {
            updateProgress()
        } else {
            nextSetOrFinish()
        }
    }
    
    private func updateProgress() {
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
        timerMode = .initial
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
    
