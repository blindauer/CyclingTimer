//
//  RPMPicker.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-19.
//

import SwiftUI

struct RPM {
    let value: Int
    let opacity: Double
}

struct RPMPicker: View {
    
    @Binding var pickerValue: Int
    @State var selectedRPM: Int
    
    var rows: [GridItem] = [
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50))
    ]
    
    var body: some View {
        VStack {
            LazyHGrid(
                rows: rows,
                alignment: .top,
                spacing: 25,
                pinnedViews: []
            ) {
                let RPMs = possibleRPMValues()
                ForEach(0..<RPMs.count) { index in
                    RPMView(rpm: RPMs[index].value,
                            opacity: RPMs[index].opacity,
                            currentSelection: selectedRPM,
                            rpmTapped: { value in
                        selectedRPM = value
                        pickerValue = value
                    })
                }
            }
        }
    }
    
    func possibleRPMValues() -> [RPM] {
        var cellData: [RPM] = []
        var opacity = 0.05
        for index in (0...19) {
            let value = 45 + index * 5
            opacity += 0.05
            cellData.append(RPM(value: value, opacity: opacity))
        }
        return cellData
    }
}

struct RPMPicker_Previews: PreviewProvider {
    static var previews: some View {
        RPMPicker(pickerValue: .constant(45), selectedRPM: 45)
    }
}

struct RPMView: View {
    var rpm: Int
    var opacity: Double
    @State var currentSelection: Int
    var rpmTapped: ((Int) -> Void)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(currentSelection == rpm ? Color.gray : Color.accentColor)
                .frame(width: 60, height: 40)
                .cornerRadius(10.0)
                .opacity(currentSelection == rpm ? 1.0 : opacity)
            HStack(spacing: 5.0) {
                Text("\(rpm)")
                    .font(.body)
                Text("RPM")
                    .font(.caption)
            }
        }
        .onTapGesture {
            rpmTapped(rpm)
        }
    }
}
