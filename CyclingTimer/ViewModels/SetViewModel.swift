//
//  SetViewModel.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-29.
//

import Foundation

struct SetViewModel {
    private var timerPlayer: TimerPlayer
    
    init(set: Set) {
        self.timerPlayer = TimerPlayer(duration: set.duration, completion: { (timerState, timeRemaining) in
            switch timerState {
            case .notStarted:
                print("not started")
            case .paused:
                print("paused")
            case .finished:
                print("finished")
            }
        })
        
    }
    
    func play() {
        timerPlayer.play()
    }
    
    func pause() {
        timerPlayer.pause()
    }
    

}
