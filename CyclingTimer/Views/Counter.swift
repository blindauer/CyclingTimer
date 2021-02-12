//
//  Counter.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-11.
//

import SwiftUI

struct Counter: View {
    @ObservedObject var timerManager = TimerManager.shared
    static let rotationCount = 100
    
    var rotatedRoundedRects: some View {
        ForEach(0..<Counter.rotationCount) { index in
            let angle = Angle.degrees(Double(index) / Double(Counter.rotationCount)) * 360.0
            
            RotatedRoundedRect(angle: angle,
                               radius: 150.0,
                               filled: Int(timerManager.progress * 100)>index)
        }
    }
    
    var body: some View {
        ZStack {
            rotatedRoundedRects
        }
        .scaledToFit()
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        Counter()
    }
}
