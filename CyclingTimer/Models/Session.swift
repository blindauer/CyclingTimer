//
//  Session.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import SwiftUI

struct Session: Codable, Identifiable {
    let id: UUID
    var name: String
    var segments: [Segment]
    var duration: Double {
        return segments.sum({ $0.duration })
    }
    var durationLabel: String {
        let minutes = Int(duration / 60)
        return "\(minutes) min"
    }
    
    init(id: UUID = UUID(), name: String = "", segments: [Segment] = [Segment()]) {
        self.id = id
        self.name = name
        self.segments = segments
    }
}

extension Session {
    struct Data: Identifiable {
        let id: UUID = UUID()
        var name: String = ""
        var segments: [Segment.Data] = [Segment.Data()]
    }
    
    var data: Data {
        let segmentsData = segments.map { Segment.getData(from: $0) }
        return Data(name: name, segments: segmentsData)
    }
    
    static func getData(from session: Session) -> Session.Data {
        let segmentsData = session.segments.map { Segment.getData(from: $0) }
        return Data(name: session.name, segments: segmentsData)
    }
    
    static func getSession(from data: Session.Data) -> Session {
        let segments = data.segments.map { Segment.getSegment(from: $0) }
        return Session(name: data.name, segments: segments)
    }

//    func set(with segmentIndex: Int, setIndex: Int) -> Set {
//        let setData = data.segments[segmentIndex].sets[setIndex]
//        return Set.getSet(from: setData)
//    }
    
    mutating func update(from data: Data) {
        name = data.name
        segments = data.segments.map { Segment.getSegment(from: $0) }
    }
}

extension Session {
    static var data: [Session] {
        [Session(name: "Sample Session 1", segments: [
            Segment(sets: [Set(description: "Warmup", duration: 120, rpm: 75, effort: 4)], type: .Warmup),
            
            Segment(sets: [Set(description: "Torque", duration: 60, rpm: 60, effort: 9),
                           Set(description: "Rev", duration: 60, rpm: 110, effort: 10),
                           Set(description: "Recovery", duration: 120, rpm: 85, effort: 3)], repetitions: 5, type: .Work)]),
         Session(name: "Sample Session 2", segments: [
             Segment(sets: [Set(description: "Warmup", duration: 120, rpm: 75, effort: 4)], type: .Warmup),
             
             Segment(sets: [Set(description: "Max Effort", duration: 30, rpm: 60, effort: 9),
                            Set(description: "Recovery", duration: 60, rpm: 110, effort: 10)], repetitions: 10, type: .Work),
             
             Segment(sets: [Set(description: "Cooldown", duration: 120, rpm: 75, effort: 4)], type: .Cooldown)]),
         Session(name: "Sample Session 3", segments: [
             Segment(sets: [Set(description: "Work", duration: 120, rpm: 95, effort: 8),
                            Set(description: "Recovery", duration: 120, rpm: 80, effort: 6)], repetitions: 10, type: .Work)])]
    }
}
