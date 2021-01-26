//
//  Timer.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import Foundation

struct Timer {
    var id = UUID() // TODO: DO I NEED THIS?
    var name: String
    var segments: [Segment]
    var duration: TimeInterval {
        return segments.sum({ $0.duration })
    }
}
