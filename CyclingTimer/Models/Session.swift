//
//  Session.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import Foundation

struct Session: Identifiable {
    var id = UUID()
    var name: String
    var segments: [Segment]
    var duration: Float {
        return segments.sum({ $0.duration })
    }
    var durationLabel: String {
        let minutes = Int(duration / 60)
        return "\(minutes) min"
    }
}
