//
//  ContentView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-25.
//

import SwiftUI

struct ContentView: View {
    var timers: [Timer] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(timers) { timer in
                    TimerCell(timer: timer)
                }
                HStack {
                    Spacer()
                    Text("\(timers.count) Timers")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Spacer()
                }
            }
            .navigationTitle("Timers")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(timers: testData)
    }
}

struct TimerCell: View {
    var timer: Timer
    
    var body: some View {
        NavigationLink(destination: Text(timer.name)) {
            VStack(alignment: .leading) {
                Text(timer.name)
                Text(timer.durationLabel)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
    }
}
