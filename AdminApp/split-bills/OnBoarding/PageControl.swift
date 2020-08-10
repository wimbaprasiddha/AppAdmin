//
//  PageControl.swift
//  split-bills
//
//  Created by wimba prasiddha on 23/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct PageControl: UIViewRepresentable {
    var NumberOfpages: Int
    
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = NumberOfpages
        control.currentPageIndicatorTintColor = #colorLiteral(red: 0.06666666667, green: 0.3019607843, blue: 0.5882352941, alpha: 1)
        control.pageIndicatorTintColor = UIColor.gray
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
}
