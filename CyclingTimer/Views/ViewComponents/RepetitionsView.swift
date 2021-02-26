//
//  RepetitionsView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-25.
//

import SwiftUI

struct RepetitionsView: View {
    @Binding var repetitions: Int
    
    var body: some View {
        Button(action: {
            if repetitions == 10 {
                repetitions = 0
            } else {
                repetitions += 1
            }
        }) {
            HStack {
                Text("# reps: \(repetitions)")
            }
        }
    }
}

struct RepetitionsView_Previews: PreviewProvider {
    static var previews: some View {
        RepetitionsView(repetitions: .constant(10))
    }
}
