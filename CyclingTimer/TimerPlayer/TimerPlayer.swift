//
//  TimerPlayer.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-01.
//

import Foundation

class TimerPlayer {
    private var timer: Timer?
    private var timeRemaining: TimeInterval
    private var completion: () -> Void
    
    required init(duration: TimeInterval, completion: @escaping () -> Void) {
        self.timeRemaining = duration
        self.completion = completion
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [unowned self] timer in
            print("fire")
            timeRemaining -= 1
            if timeRemaining <= 0 {
                self.completion()
            }
        }
    }
    
    func pause() {
        timer?.invalidate()
        // keep track of the current progress in order to start another timer for remaining seconds
    }
}
