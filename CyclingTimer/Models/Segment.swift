//
//  Segment.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import Foundation

enum SegmentType: String, Codable {
    case Warmup
    case Work
    case Cooldown
}

struct Segment: Codable, Identifiable {
    let id: UUID
    var sets: [Set]
    var repetitions: Int
    var type: SegmentType
    var duration: Double {
        let segmentDuration = sets.sum({ $0.duration })
        if repetitions == 0 {
            return segmentDuration
        } else {
            return segmentDuration * Double(repetitions)
        }
    }
    
    init(id: UUID = UUID(), sets: [Set] = [], repetitions: Int = 0, type: SegmentType = .Work) {
        self.id = id
        self.sets = sets
        self.repetitions = repetitions
        self.type = type
    }
}

extension Segment {
    struct Data: Identifiable {
        let id: UUID = UUID()
        var sets: [Set.Data] = []
        var repetitions: Int = 0
        var type: SegmentType = .Work
    }

    var data: Data {
        let setsData = sets.map { Set.getData(from: $0) }
        return Data(sets: setsData, repetitions: repetitions, type: type)
    }
    
    static func getData(from segment: Segment) -> Segment.Data {
        let setsData = segment.sets.map { Set.getData(from: $0) }
        return Data(sets: setsData, repetitions: segment.repetitions, type: segment.type)
    }
    
    static func getSegment(from data: Segment.Data) -> Segment {
        let sets = data.sets.map { Set.getSet(from: $0) }
        return Segment(sets: sets, repetitions: data.repetitions, type: data.type)
    }

    mutating func update(from data: Data) {
        let newSets = data.sets.map { Set.getSet(from: $0) }
        sets = newSets
        repetitions = data.repetitions
        type = data.type
    }
}
