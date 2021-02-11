//
//  SessionListViewer.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-25.
//

import SwiftUI

struct SessionListViewer: View {
    @EnvironmentObject var store: SessionStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.sessions) { session in
                    NavigationLink(destination: SessionDetail(session: session)) {
                        SessionRow(session: session)
                    }
                }
                .onMove(perform: moveSession)
                .onDelete(perform: deleteSession)
            }
            .navigationTitle("Sessions")
            .toolbar { // TODO: Needs better design
                HStack {
                    Button(action: newSession) {
                        Label("New", systemImage: "plus.circle")
                    }
                    EditButton()
                }
            }
        }
    }
    
    func newSession() {
        withAnimation {
            let easySet = Set(description: "Easy", duration: 1200, rpm: 75, effort: 4)
            let easySession = Session(name: "Easy", segments: [Segment(sets: [easySet], repetitions: 0, type: .work)])
            store.sessions.append(easySession)
        }
    }
    
    func moveSession(from: IndexSet, to: Int) {
        withAnimation {
            store.sessions.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func deleteSession(offsets: IndexSet) {
        withAnimation {
            store.sessions.remove(atOffsets: offsets)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionListViewer()
                .environmentObject(testStore)
                /*
                .preferredColorScheme(.dark)
                .environment(\.locale, Locale(identifier: "ru"))
                */
        }
    }
}
