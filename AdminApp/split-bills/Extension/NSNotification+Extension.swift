//
//  NSNotification+Extension.swift
//  split-bills
//
//  Created by Willa on 27/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation

extension NSNotification {
    static let polySelected = NSNotification.Name.init("polySelected")
}

enum NotificationCenterUserInfo: String{
    case poly = "poly"
}
