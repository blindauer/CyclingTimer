//
//  SessionDetailView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-17.
//

import SwiftUI

struct SessionDetailView: View {
    @Binding var session: Session
    @State private var data: Session.Data = Session.Data()
    @State private var isPresented = false
    @State private var newSessionData = Session.Data()
    
    var body: some View {
        List {
            Section(header: Text("Summary")) {
                NavigationLink(destination: ActiveSessionView(session: $session)){
                    Label("Start", systemImage: "flag")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Duration", systemImage: "clock")
                        .accessibilityLabel(Text("Meeting length"))
                    Spacer()
                    Text(TimerManager.timeStamp(time: session.duration))
                }
            }
            ForEach(0..<session.segments.count) { segmentIndex in
                Section (footer: Text("# repeats \(session.segments[segmentIndex].repetitions)")) {
                    ForEach(0..<session.segments[segmentIndex].sets.count) { setIndex in
                        SetView(set: session.segments[segmentIndex].sets[setIndex])
                    }
                }
            }
        }
        .navigationTitle(session.name)
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $isPresented) {
            NavigationView {
                NewSessionView(sessionData: $newSessionData)
            }
        }
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SessionDetailView(session: .constant(Session.data[0]))
        }
    }
}
