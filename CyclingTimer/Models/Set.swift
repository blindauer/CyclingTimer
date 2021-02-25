//
//  Set.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import Foundation
import SwiftUI

struct Set: Codable {
    var description: String
    var duration: Double
    var rpm: Int = 45
    var effort: Int = 1
    var color: Color = Color.accentColor
}

extension Set {
    struct Data: Identifiable {
        let id: UUID = UUID()
        var description: String = ""
        var duration: Double = 0
        var rpm: Int = 45
        var effort: Int = 1
        var color: Color = Color.accentColor
    }

    var data: Data {
        return Data(description: description, duration: duration, rpm: rpm, effort: effort, color: color)
    }
    
    static func getData(from set: Set) -> Set.Data {
        return Data(description: set.description, duration: set.duration, rpm: set.rpm, effort: set.effort, color: set.color)
    }
    
    static func getSet(from data: Set.Data) -> Set {
        return Set(description: data.description, duration: data.duration, rpm: data.rpm, effort: data.effort, color: data.color)
    }

    mutating func update(from data: Data) {
        description = data.description
        duration = data.duration
        rpm = data.rpm
        effort = data.effort
        color = data.color
    }
}
