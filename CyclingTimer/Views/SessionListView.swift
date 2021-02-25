//
//  SessionListView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-25.
//

import SwiftUI

struct SessionListView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Binding var sessions: [Session]
    @State private var isPresented = false
    @State private var newSessionData = Session.Data()
    let saveAction: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sessions) { session in
                    NavigationLink(destination: SessionDetailView(session: binding(for: session))) {
                        SessionView(session: session)
                    }
                }
                .onMove(perform: moveSession)
                .onDelete(perform: deleteSession)
            }
            .navigationTitle("Sessions")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }

                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    NewSessionView(sessionData: $newSessionData)
                        .navigationBarItems(leading: Button("Dismiss") {
                            isPresented = false
                        }, trailing: Button("Add") {
                            sessions.append(Session.getSession(from: newSessionData))
                            isPresented = false
                        })
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
    }
    
    // Utility method to retrieve a binding from an individual session
    private func binding(for session: Session) -> Binding<Session> {
        guard let sessionIndex = sessions.firstIndex(where: { $0.id == session.id }) else {
            fatalError("Can't find session in array")
        }
        return $sessions[sessionIndex]
    }
    
    func moveSession(from: IndexSet, to: Int) {
        withAnimation {
            sessions.move(fromOffsets: from, toOffset: to)
        }
    }
    
    func deleteSession(offsets: IndexSet) {
        withAnimation {
            sessions.remove(atOffsets: offsets)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SessionListView(sessions: .constant(Session.data), saveAction: {})
        }
    }
}
