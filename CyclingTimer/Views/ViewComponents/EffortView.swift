//
//  EffortView.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-22.
//

import SwiftUI

let lightGray: Color = Color.init(white: 0.8)
let effortColors: [Color] = [.green, .green, .green, .green, .yellow, .yellow, .orange, .orange, .red, .red]
let shortEdge: CGFloat = 5
let longEdge: CGFloat = 30

struct NumberBadgeView: View {
    var effort: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(lightGray)
                .frame(width: longEdge, height: longEdge)
                .cornerRadius(6.0)
            Text("\(effort)")
                .font(.title2)
                .foregroundColor(.white)
        }
    }
}

struct BarView: View {
    var effort: Int
    var width: CGFloat
    var height: CGFloat
    var color: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .frame(width: width, height: height)
                .cornerRadius(6.0)
        }
    }
}

struct EffortView: View {
    var effort: Int
    var useColor: Bool = true
    var tintColor: Color = .black
    
    var body: some View {
        HStack(spacing: 4.0) {
            HStack(spacing: 2.0) {
                ForEach(0..<effortColors.count) { index in
                    let shadedColor = useColor ? effortColors[index] : tintColor.opacity(0.75)
                    let color = index + 1 > effort ? lightGray : shadedColor
                    BarView(effort: effort, width: shortEdge, height: longEdge, color: color)
                }
            }
            NumberBadgeView(effort: effort)
        }
    }
}

struct EffortView_Previews: PreviewProvider {
    static var previews: some View {
        EffortView(effort: 1)
            .previewLayout(.fixed(width: 150, height: 100))
        EffortView(effort: 9, useColor: false, tintColor: .blue)
            .previewLayout(.fixed(width: 150, height: 100))
    }
}
