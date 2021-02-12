//
//  RotatedRoundedRect.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-02-11.
//

import SwiftUI

struct RotatedRoundedRect: View {
    
    let angle: Angle
    let radius: Double
    let filled: Bool
    
    var body: some View {
        Rectangle()
            .fill(Color.green)
            .frame(width: 8, height: 40)
            .cornerRadius(50.0)
            .rotationEffect(angle, anchor: .center)
            .offset(offset(angle: angle, hypotenuse: radius))
            .opacity(filled ? 1.0 : 0.3)
    }
    
    private func offset(angle: Angle, hypotenuse: Double) -> CGSize {
        let x = hypotenuse * sin(angle.radians)
        let y = Double.squareRoot((hypotenuse * hypotenuse) - (x * x))()
        
        switch angle.degrees {
        case 0 ... 90:
            return CGSize(width: x, height: y * -1)
        case 90 ... 180:
            return CGSize(width: x, height: y)
        case 180 ... 270:
            return CGSize(width: x, height: y)
        case 270 ... 360:
            return CGSize(width: x, height: y * -1)
        default:
            return CGSize.zero
        }
    }
}

struct RoundedRectTick_Previews: PreviewProvider {
    static var previews: some View {
        RotatedRoundedRect(angle: Angle(degrees: 300), radius: 100.0, filled: false)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
