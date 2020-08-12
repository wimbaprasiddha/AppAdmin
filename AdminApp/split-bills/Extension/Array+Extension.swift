//
//  Array+Extension.swift
//  split-bills
//
//  Created by Willa on 30/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    public subscript(safe index: Int) -> Element?{
           guard startIndex <= index && index < endIndex else {
               return nil
           }
           return self[index]
       }
    
}
