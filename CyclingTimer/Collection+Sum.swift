//
//  Collection+Sum.swift
//  CyclingTimer
//
//  Created by Maria Civilis on 2021-01-26.
//

import Foundation

// TODO: Refresh on generics and reduce
// https://forums.swift.org/t/pitch-method-to-sum-numeric-arrays/24170

extension Collection where Element: Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}

extension Collection {
    func sum<T: Numeric>(_ transform: (Element) throws -> T) rethrows -> T {
        return try map(transform).sum()
    }
}
