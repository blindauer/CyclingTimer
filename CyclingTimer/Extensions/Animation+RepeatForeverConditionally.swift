//
//  Animation+RepeatForeverConditionally.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-03-07.
//

import SwiftUI

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
