//
//  SessionDetail.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-27.
//

import SwiftUI

struct SessionDetail: View {
    var session: Session
    var setViewModel: SetViewModel
    @State var progressValue = Float.zero
    @State private var playing = false
    
    var body: some View {
        ZStack {
            VStack {
                ProgressView(progress: $progressValue)
                    .padding(40.0)
                Button(action: play) {
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
        .navigationTitle(session.name)
    }
    
    func play() {
        //setViewModel.play()
        //self.progressValue += randomValue
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let testSet = Set(description: "TestSet", duration: 30, rpm: 75, effort: 4)
            SessionDetail(session: testData[0], setViewModel: SetViewModel(set: testSet))
        }
    }
}
