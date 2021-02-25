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
        VStack() {
            HStack {
                Text(set.description)
                Spacer()
                Image(systemName: "stopwatch.fill")
                    .foregroundColor(set.color)
                    .font(.title2)
                Text(TimerManager.timeStamp(time: set.duration))
            }
            HStack {
                HStack(spacing: 0) {
                    Text("\(set.rpm)")
                        .font(.title2)
                    Text("RPM")
                        .font(.subheadline)
                }
                Spacer()
                HStack(spacing: 0) {
                    HorizontalEffortView(effort: set.effort)
                }
            }
        }
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        SetView(set: Session.data[0].segments[0].sets[0])
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
