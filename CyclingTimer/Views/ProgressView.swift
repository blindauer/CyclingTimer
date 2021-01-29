//
//  ProgressView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-28.
//

import SwiftUI

struct ProgressView: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
            
            VStack {
                Text("1:07") //Placeholder
                    .font(.largeTitle)
                    .bold()
                Rectangle()
                    .frame(height: 2.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(0)
                Text("75 RPM") //Placeholder
                    .font(.largeTitle)
                    .bold()
            }
            .padding(50)
        }
    }
}
