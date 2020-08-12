//
//  ActifityIndicatorView.swift
//  split-bills
//
//  Created by Willa on 26/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import UIKit
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
     @Binding var isAnimating: Bool
     let style: UIActivityIndicatorView.Style

     func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
         let ai = UIActivityIndicatorView(style: style)
         ai.color = .white
         return ai
     }

     func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
         isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
     }
 }
