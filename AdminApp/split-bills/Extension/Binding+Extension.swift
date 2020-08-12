//
//  Binding+Extension.swift
//  split-bills
//
//  Created by Willa on 27/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

extension Binding {
    /// Execute block when value is changed.
    ///
    /// Example:
    ///
    ///     Slider(value: $amount.didSet { print($0) }, in: 0...10)
    func didSet(execute: @escaping (Value) ->Void) -> Binding {
        return Binding(
            get: {
                return self.wrappedValue
            },
            set: {
                execute($0)
                self.wrappedValue = $0
            }
        )
    }
}
