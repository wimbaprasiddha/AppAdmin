//
//  DoctorModel.swift
//  split-bills
//
//  Created by Willa on 30/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation

struct DoctorModel: Codable, Identifiable{
    var id: UUID = UUID()
    var name: String
    var schedule: String
    var queueNumber: Int
    var polyID: Int
    var polyName: String
}
