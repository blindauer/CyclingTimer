//
//  CircularBarView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

struct CircularBarView: View {
    @ObservedObject var timerManager = TimerManager.shared
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 30.0)
                .opacity(0.3)
                .foregroundColor(.blue)
            Circle()
                .trim(from: 0.0, to: CGFloat(timerManager.progress))
                .stroke(style: StrokeStyle(lineWidth: 30.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut)
        }
        .padding(30.0)
    }
}

struct CircularBarView_Previews: PreviewProvider {
    static var previews: some View {
        CircularBarView()
            .previewLayout(.fixed(width: 400, height: 400))
    }
}
