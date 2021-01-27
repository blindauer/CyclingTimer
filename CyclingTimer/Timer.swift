//
//  Timer.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import Foundation

struct Timer: Identifiable {
    var id = UUID() // TODO: DO I NEED THIS?
    var name: String
    var segments: [Segment]
    var duration: TimeInterval {
        return segments.sum({ $0.duration })
    }
    var durationLabel: String {
        let minutes = Int(duration / 60)
        return "\(minutes) min"
    }
}

let testData = [
        
    Timer(name: "Morning Workout", segments: [
        Segment(sets: [Set(description: "Warmup", duration: 120, rpm: 75, effort: 4)], type: .warmup),
        
        Segment(sets: [Set(description: "Torque", duration: 60, rpm: 60, effort: 9),
                       Set(description: "Rev", duration: 60, rpm: 110, effort: 10),
                       Set(description: "Recovery", duration: 120, rpm: 85, effort: 3)], repetitions: 5, type: .work)
    ]),
    
    Timer(name: "HIIT Workout", segments: [
        Segment(sets: [Set(description: "Warmup", duration: 180, rpm: 70, effort: 4),
                       Set(description: "Warmup", duration: 120, rpm: 80, effort: 7),
                       Set(description: "Warmup", duration: 60, rpm: 90, effort: 8),
                       Set(description: "Recovery", duration: 120, rpm: 75, effort: 4)], type: .warmup),
        
        Segment(sets: [Set(description: "All out", duration: 30, rpm: 100, effort: 10),
                       Set(description: "Recovery", duration: 60, rpm: 85, effort: 3)], repetitions: 16, type: .work),
        
        Segment(sets: [Set(description: "Cooldown", duration: 180, rpm: 75, effort: 4)], type: .cooldown)
    ]),
    
    Timer(name: "Forty twenties", segments: [
        Segment(sets: [Set(description: "Warmup", duration: 60, rpm: 100, effort: 7),
                       Set(description: "Warmup", duration: 60, rpm: 90, effort: 4)], type: .warmup),
        
        Segment(sets: [Set(description: "40", duration: 40, rpm: 90, effort: 9),
                       Set(description: "20", duration: 20, rpm: 75, effort: 3)], repetitions: 5, type: .work),
        
        Segment(sets: [Set(description: "Recovery", duration: 150, rpm: 75, effort: 4)], type: .work),
        
        Segment(sets: [Set(description: "40", duration: 40, rpm: 90, effort: 9),
                       Set(description: "20", duration: 20, rpm: 75, effort: 3)], repetitions: 5, type: .work),
        
        Segment(sets: [Set(description: "Recovery", duration: 150, rpm: 75, effort: 4)], type: .work),
        
        Segment(sets: [Set(description: "40", duration: 40, rpm: 90, effort: 9),
                       Set(description: "20", duration: 20, rpm: 75, effort: 3)], repetitions: 5, type: .work),
        
        Segment(sets: [Set(description: "Recovery", duration: 150, rpm: 75, effort: 4)], type: .work),
        
        Segment(sets: [Set(description: "40", duration: 40, rpm: 90, effort: 9),
                       Set(description: "20", duration: 20, rpm: 75, effort: 3)], repetitions: 5, type: .work),
        
        Segment(sets: [Set(description: "Recovery", duration: 150, rpm: 75, effort: 4)], type: .work),
        
        Segment(sets: [Set(description: "40", duration: 40, rpm: 90, effort: 9),
                       Set(description: "20", duration: 20, rpm: 75, effort: 3)], repetitions: 5, type: .work),
        
        Segment(sets: [Set(description: "Cooldown", duration: 180, rpm: 75, effort: 4)], type: .cooldown)
    ])
]
