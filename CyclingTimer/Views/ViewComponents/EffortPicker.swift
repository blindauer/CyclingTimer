//
//  EffortPicker.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-22.
//

import SwiftUI

struct Effort {
    let value: Int
    let color: Color
}

struct EffortPicker: View {
    
    //@Binding var pickerValue: Int
    
    var body: some View {
        Text("TODO")
    }
}

//struct EffortPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        EffortPicker()
//            .previewLayout(.fixed(width: 500, height: 500))
//    }
//}

struct EffortView: View {
    let lightGray: Color = Color.init(white: 0.8)
    let effortColors: [Color] = [.green, .green, .green, .green, .yellow, .yellow, .orange, .orange, .red, .red]
    let spacing: CGFloat = 1
    let barHeight: CGFloat = 5
    let barWidth: CGFloat = 35
    var effort: Int
    private var totalHeight: CGFloat {
        return CGFloat(effortColors.count - 1) * (barHeight + spacing)
    }
    var effortBars: some View {
        ForEach(0..<effortColors.count) { index in
            Rectangle()
                .fill(index + 1 > effort ? lightGray : effortColors[index])
                .frame(width: barWidth, height: barHeight)
                .cornerRadius(barHeight / 2)
                .offset(y: CGFloat(index) * (barHeight + spacing) * -1)
        }
    }
    var body: some View {
        HStack(spacing: 5.0) {
            ZStack {
                Rectangle()
                    .fill(lightGray)
                    .frame(width: totalHeight, height: totalHeight)
                    .cornerRadius(10)
                Text("\(effort)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            ZStack {
                effortBars
            }
            .offset(y: 0.5 * totalHeight)
        }
    }
}

struct EffortView_Previews: PreviewProvider {
    static var previews: some View {
        EffortView(effort: 10)
            .previewLayout(.fixed(width: 100, height: 70))
    }
}
