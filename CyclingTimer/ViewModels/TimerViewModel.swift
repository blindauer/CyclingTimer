//
//  TimerViewModel.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-29.
//

import Foundation

struct TimerViewModel {
    private var timeRemaining: TimeInterval
    private var timer: Timer
    
    init(set: Set) {
        self.timeRemaining = set.duration
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            //fireTimer(timer: timer)
            print("fire")
        }
    }
    
    mutating func fireTimer(timer: Timer) {
        timeRemaining -= 1
        print("Time remaining is \(timeRemaining)")
        if timeRemaining <= 0 {
            timer.invalidate()
            print("end")
        }
    }
}
