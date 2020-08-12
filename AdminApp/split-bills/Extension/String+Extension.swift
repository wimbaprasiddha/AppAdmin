//
//  String+Extension.swift
//  AdminApp
//
//  Created by Willa on 13/08/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation

extension String {

    func slice(from: String, to: String) -> String? {

        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
