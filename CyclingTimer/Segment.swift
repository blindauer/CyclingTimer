//
//  Segment.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import Foundation

enum SegmentType {
    case warmup
    case work
    case cooldown
}

struct Segment {
    var sets: [Set]
    var repetitions = 0
    var type: SegmentType
    var duration: TimeInterval {
        let segmentDuration = sets.sum({ $0.duration })
        if repetitions == 0 {
            return segmentDuration
        } else {
            return segmentDuration * Double(repetitions)
        }
    }
}
