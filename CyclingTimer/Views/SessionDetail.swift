//
//  SessionDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct SessionDetail: View {
    private var increment: Float
    var session: Session
    var setViewModel: SetViewModel
    @State var progressValue = Float.zero
    @State private var playing = false
    
    init(session: Session) {
        self.increment = 1 / session.segments[0].sets[0].duration
        self.session = session
        self.setViewModel = SetViewModel(set: session.segments[0].sets[0], progressUpdated: {(timerState, timeElapsed, timeRemaining) in
            print("Time elapsed: \(timeElapsed), time remaining: \(timeRemaining)")
            //updateProgress(timeElapsed: timeElapsed, timeRemaining: timeRemaining)
        })
    }
    
    var body: some View {
        ZStack {
            VStack {
                ProgressView(progress: $progressValue)
                    .padding(40.0)
                Button(action: play) {
                    Image(systemName: "play.fill")
                    .padding(15.0)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2.0)
                    )
                }
                Spacer()
            }
            Spacer()
        }
        .navigationTitle(session.name)
    }
    
    func play() {
        setViewModel.play()
    }
    
    mutating func updateProgress(timeElapsed: Float, timeRemaining: Float) {
        self.progressValue = timeElapsed / (timeElapsed + timeRemaining)
    }
}

//struct SessionDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            let testSet = Set(description: "TestSet", duration: 30, rpm: 75, effort: 4)
//            SessionDetail(session: testData[0], setViewModel: SetViewModel(set: testSet))
//        }
//    }
//}
