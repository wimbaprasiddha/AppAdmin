//
//  NotifModel.swift
//  split-bills
//
//  Created by Willa on 09/08/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation

struct NotifModel: Codable{
    let message_id: String
}

enum NotificationTopics: String{
    case splitBill = "/topics/split-bills"
    case appAdmin = "/topics/appAdmin"
}

extension NotifModel{
    static func requestSendNotificaion(title: String, body: String, topics: NotificationTopics) -> Resource<NotifModel>{
        let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
        let headers = [
            "Content-Type": "application/json",
            "Authorization" : KeyHelper.fcmKey.rawValue
        ]
        let parameters: [String: Any] = [
            "to" : topics.rawValue,
            "notification": [
                [
                    "title" : "\(title)",
                    "body": "\(body)"
                ]
            ]
        ]
        return Resource<NotifModel>(url: url, httpMethod: .post, params: parameters, headers: headers, isUserAuthHeader: false, cacheID: nil, data: nil)
    }
}
