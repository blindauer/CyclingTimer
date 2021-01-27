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
            List(timers) { timer in
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(timers: testData)
    }
}
