//
//  QueueList.swift
//  split-bills
//
//  Created by wimba prasiddha on 10/08/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import SwiftUI

struct QueueList: View {
    var body: some View {
        Form {
        ForEach(0..<25,id: \.self){ _ in
        Text("Patient name")
            }
        }
    }
}

struct QueueList_Previews: PreviewProvider {
    static var previews: some View {
        QueueList()
    }
}
