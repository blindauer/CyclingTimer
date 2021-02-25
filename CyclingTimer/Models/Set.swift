//
//  Set.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import Foundation

struct Set: Codable {
    var description: String
    var duration: Double
    var rpm: Int
    var effort: Int
}

extension Set {
    struct Data: Identifiable {
        let id: UUID = UUID()
        var description: String = ""
        var duration: Double = 0
        var rpm: Int = 0
        var effort: Int = 1
    }

    var data: Data {
        return Data(description: description, duration: duration, rpm: rpm, effort: effort)
    }
    
    static func getData(from set: Set) -> Set.Data {
        return Data(description: set.description, duration: set.duration, rpm: set.rpm, effort: set.effort)
    }
    
    static func getSet(from data: Set.Data) -> Set {
        return Set(description: data.description, duration: data.duration, rpm: data.rpm, effort: data.effort)
    }

    mutating func update(from data: Data) {
        description = data.description
        duration = data.duration
        rpm = data.rpm
        effort = data.effort
        
    }
}
