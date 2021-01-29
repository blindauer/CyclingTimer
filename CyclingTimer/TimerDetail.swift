//
//  TimerDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct TimerDetail: View {
    var timer: Session
    @State var progressValue = Float.zero
    @State private var playing = false
    
    var body: some View {
        ZStack {
            VStack {
                ProgressView(progress: $progressValue, set: timer.segments[0].sets[0])
                    .padding(40.0)
                Button(action: incrementProgress) {
                    Image(systemName: "play.fill")
                    .padding(15.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(lineWidth: 2.0)
                    )
                }
                Spacer()
            }
            Spacer()
        }
        .navigationTitle(timer.name)
    }
    
    func incrementProgress() {
        let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
        self.progressValue += randomValue
    }
}

struct TimerDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerDetail(timer: testData[0])
        }
    }
}
