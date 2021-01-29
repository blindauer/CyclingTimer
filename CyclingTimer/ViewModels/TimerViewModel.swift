//
//  TimerViewModel.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-29.
//

import Foundation

struct TimerViewModel {
    var timeRemaining = 0
    var set: Set {
        didSet {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                //fireTimer(timer: timer)
                print("fire")
            }
        }
    }
    
    mutating func fireTimer(timer: Timer) {
        timeRemaining -= 1
        if timeRemaining <= 0 {
            timer.invalidate()
        }
    }
}
