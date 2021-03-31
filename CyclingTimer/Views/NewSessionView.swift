//
//  NewSessionView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-17.
//

import SwiftUI

struct NewSessionView: View {
    @Binding var sessionData: Session.Data
    @State private var isPresented = false
    @State private var newSetData = Set.Data()
    @State private var reps: String = ""
    @State private var repsIsEditing = false
    
    private var addSetButton: some View {
        Button(action: {
            isPresented.toggle()
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Set")
            }
        }
    }
    
    private var addSegmentButton: some View {
        Button(action: {
            sessionData.segments.append(Segment.Data())
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Segment")
            }
        }
    }
    
    var body: some View {
        List {
            Section {
                TextField("Session name", text: $sessionData.name)
                    .font(.largeTitle)
            }
            ForEach(sessionData.segments) { segmentData in
                Section() {
                    ForEach(sessionData.segments[index(for: segmentData)].sets) { setData in
                        SetView(set: Set.getSet(from: setData))
                    }
                    addSetButton
                    HStack {
                        Text("# of reps:")
                            .foregroundColor(lightGray)
                        TextField(
                            "\(sessionData.segments[index(for: segmentData)].repetitions)",
                            text: $reps
                        ) { isEditing in
                            repsIsEditing = repsIsEditing
                        } onCommit: {
                            sessionData.segments[index(for: segmentData)].repetitions = Int(reps) ?? 0
                        }
                        .keyboardType(.numberPad)
                        .foregroundColor(lightGray)
                    }
                    .sheet(isPresented: $isPresented) {
                        NavigationView {
                            AddSet(setData: $newSetData)
                                .navigationBarItems(leading: Button("Dismiss") {
                                    isPresented = false
                                    newSetData = Set.Data()
                                }, trailing: Button("Add") {
                                    sessionData.segments[index(for: segmentData)].sets.append(newSetData)
                                    isPresented = false
                                    newSetData = Set.Data()
                                })
                        }
                    }
                }
            }
            Section {
                addSegmentButton
            }
        }
        .listStyle(InsetGroupedListStyle())
        .toolbar {
            ToolbarItem(placement: .automatic) {
                EditButton()
            }
        }
    }
    
    private func index(for segmentData: Segment.Data) -> Int {
        guard let segmentIndex = sessionData.segments.firstIndex(where: { $0.id == segmentData.id }) else {
            fatalError("Can't find segment in array")
        }
        return segmentIndex
    }
}

struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        let warmupSets = [Set(description: "Warmup", duration: 60, rpm: 75, effort: 6, color: .green)]
        let workSets = [Set(description: "Tempo", duration: 60, rpm: 100, effort: 9, color: .red),
                        Set(description: "Recover", duration: 60, rpm: 70, effort: 4, color: .yellow)]
        let segments = [Segment(sets: warmupSets, repetitions: 0, type: .Warmup),
                        Segment(sets: workSets, repetitions: 2, type: .Work)]
        let existingSession = Session(name: "Morning", segments: segments)
            
        NewSessionView(sessionData: .constant(Session.getData(from: existingSession)))
    }
}
