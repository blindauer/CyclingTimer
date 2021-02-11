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

class TimerManager: ObservableObject {
    
    static var shared = TimerManager()

    @Published var timerMode: TimerMode = .initial
    @Published var timeRemaining = 60 // FIX ME
    @Published var progress: Float = .zero
    
    private var timeElapsed: Float = .zero
    private var timer = Timer()
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            if self.timeRemaining == 0 {
                self.reset()
            }
            self.timeElapsed += 1
            self.timeRemaining -= 1
            self.progress = Float(self.timeElapsed) / 60.0  // FIX ME
        })
    }
    
    func reset() {
        timerMode = .initial
        timeRemaining = 60 // FIX ME
        progress = 0
        timer.invalidate()
    }
    
    func pause() {
        timerMode = .paused
        timer.invalidate()
    }
}
    
