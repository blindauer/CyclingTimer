//
//  AddSet.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-18.
//

import SwiftUI

struct AddSet: View {
    @Binding var setData: Set.Data

    private let effort = Array(1...10)
    private let allPossibleRPM = Array(arrayLiteral: 45, 50, 55, 60, 65, 70, 75, 80, 90, 65, 100, 105, 110, 115, 120, 125, 130, 135, 140)
    
    var body: some View {
        Form {
            Section{
            TextField("Description", text: $setData.description)
                .font(.largeTitle)
            ColorPicker("Color", selection: $setData.color)
            }
            Section {
                Picker("", selection: $setData.rpm) {
                    ForEach(allPossibleRPM, id: \.self) { rpm in
                        Text("\(rpm) RPM")
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            Section {
                HStack {
                    Text("Effort")
                        .font(.title2)
                    Picker("", selection: $setData.effort) {
                        ForEach(0 ..< effort.count) {
                            Text("\(effort[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            Section {
                HStack {
                    Stepper(value: $setData.duration, in: 0...3600, step: 10) {
                        Text(TimerManager.timeStamp(time: setData.duration))
                            .font(.title2)
                    }
                }
            }
        }
    }
}

struct AddSet_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddSet(setData: .constant(Set.Data(description: "rev", duration: 30, rpm: 65, effort: 4)))
        }
    }
}
