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

enum ResetMode {
    case set
    case session
}

class TimerManager: ObservableObject {

    @Published var timerMode: TimerMode = .initial
    @Published var timeStamp: String
    @Published var progress: Double = .zero
    
    private var segmentIndex: Int = 0
    private var setIndex: Int = 0
    
    private var timer = Timer()
    private var timeElapsed: Double = .zero
    private var session: Session
    
    init(session: Session) {
        self.session = session
        self.timeStamp = TimerManager.timeStamp(time: session.segments[segmentIndex].sets[setIndex].duration)
    }
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.timerFired()
        })
    }
    
    func pause() {
        timerMode = .paused
        timer.invalidate()
    }
    
    private func updateProgress() {
        let duration = session.segments[segmentIndex].sets[setIndex].duration
        timeElapsed += 0.1
        timeStamp = TimerManager.timeStamp(time: duration - timeElapsed)
        progress = timeElapsed / duration
    }
    
    private func reset(resetMode: ResetMode) {
        timerMode = .initial
        progress = 0
        timeElapsed = 0
        timer.invalidate()
        if resetMode == .set {
            return
        }
        // Full reset
        segmentIndex = 0
        setIndex = 0
        let time = session.segments[segmentIndex].sets[setIndex].duration - timeElapsed
        timeStamp = TimerManager.timeStamp(time: time)
    }
    
    private func timerFired() {
        if Int(timeElapsed) < Int(session.segments[segmentIndex].sets[setIndex].duration) {
            updateProgress()
        } else {
            nextSetOrFinish()
        }
    }
    
    private func nextSetOrFinish() {
        let lastSegment = session.segments.count - 1
        let lastSet = session.segments[segmentIndex].sets.count - 1
        
        if setIndex == lastSet && segmentIndex == lastSegment {
            reset(resetMode: .session)
            return
        }
        reset(resetMode: .set)
        if setIndex == lastSet  {
            setIndex = 0
            segmentIndex += 1
        } else {
            setIndex += 1
        }
        start()
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
    
