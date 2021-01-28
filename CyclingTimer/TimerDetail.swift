//
//  TimerDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct TimerDetail: View {
    var timer: Timer
    @State var progressValue = Float.zero
    
    var body: some View {
        ZStack {
            ProgressBar(progress: $progressValue, set: timer.segments[0].sets[0])
                .frame(width: 150.0, height: 150.0)
                .padding(40.0)
            Spacer()
        }

    }
}

struct TimerDetail_Previews: PreviewProvider {
    static var previews: some View {
        TimerDetail(timer: testData[0])
    }
}
