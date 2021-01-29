//
//  ContentView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-25.
//

import SwiftUI

struct ContentView: View {
    var sessions: [Session] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sessions) { session in
                    SessionCell(session: session)
                }
                HStack {
                    Spacer()
                    Text("\(sessions.count) sessions")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Spacer()
                }
            }
            .navigationTitle("Sessions")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sessions: testData)
    }
}

struct SessionCell: View {
    var session: Session
    
    var body: some View {
        NavigationLink(destination: Text(session.name)) {
            VStack(alignment: .leading) {
                Text(session.name)
                Text(session.durationLabel)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
    }
}
