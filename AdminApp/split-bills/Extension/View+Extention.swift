//
//  View+Extention.swift
//  split-bills
//
//  Created by wimba prasiddha on 12/08/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
