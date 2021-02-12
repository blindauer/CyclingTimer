//
//  TimerView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-10.
//

import SwiftUI

struct TimerView: View {
    
    var body: some View {
        VStack {
            ClockView()
            Spacer()
            ZStack {
                Counter()
                TimerButtonView()
                //CircularBarView()
            }
            Spacer()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}