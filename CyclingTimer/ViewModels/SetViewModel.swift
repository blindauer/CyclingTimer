//
//  SetViewModel.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-29.
//

import Foundation

enum TimerState {
    case notStarted
    case paused
    case inProgress
    case finished
}

typealias ProgressUpdated = (TimerState, Float, Float) -> Void

class SetViewModel {
    private var timer: Timer?
    private var timeRemaining: Float
    private var duration: Float
    private var timeElapsed = Float.zero
    var progressUpdated: ProgressUpdated
    var progress = Float.zero
    
    init(set: Set, progressUpdated: @escaping (TimerState, Float, Float) -> Void) {
        self.timeRemaining = set.duration
        self.duration = set.duration
        self.progressUpdated = progressUpdated
    }
    
    func play() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] timer in
            timeElapsed += 1
            timeRemaining -= 1
            progress = timeElapsed / duration
            if timeRemaining <= 0 {
                self.progressUpdated(.finished, timeElapsed, timeRemaining)
                timer.invalidate()
            } else {
                self.progressUpdated(.inProgress, timeElapsed, timeRemaining)
            }
        }
    }
    
    func pause() {
        timer?.invalidate()
        // keep track of the current progress in order to start another timer for remaining seconds
    }
    

}
