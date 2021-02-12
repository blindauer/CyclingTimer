//
//  Helper.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import Foundation


func secondsToMinutesAndSeconds(seconds: Int) -> String {
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    return "\(minuteStamp) : \(secondStamp)"
}
