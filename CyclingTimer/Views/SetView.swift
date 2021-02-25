//
//  SetView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-22.
//

import SwiftUI

struct SetView: View {
    @State var set: Set

    var body: some View {
        HStack() {
            Text(set.description)
            Spacer()
            HStack(spacing: 0) {
                Text("\(set.rpm)")
                    .font(.title2)
                Text("RPM")
                    .font(.subheadline)
            }
            .foregroundColor(effortColor(effort: set.effort))
            HStack(spacing: 0) {
                Image(systemName: "waveform.path.ecg.rectangle.fill")
                    .opacity(0.5)
                    .font(.title2)
                Text("\(set.effort)")
                    .font(.title2)
                    .opacity(0.5)
            }
            .foregroundColor(effortColor(effort: set.effort))
            Text(TimerManager.timeStamp(time: set.duration))
        }
    }
    
    private func effortColor(effort: Int) -> Color {
        if effort <= 4 {
            return .green
        } else if effort <= 5 {
            return .yellow
        } else if effort <= 7 {
            return .orange
        } else {
            return .red
        }
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        SetView(set: Session.data[0].segments[0].sets[0])
    }
}
