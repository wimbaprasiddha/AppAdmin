//
//  PushNotificationService.swift
//  AdminApp
//
//  Created by Willa on 13/08/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation

class PushNotificationService {
    func sendPushNotification(title: String, body: String, topics: NotificationTopics) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : "\(topics.rawValue)",
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]

        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAARGgw_5M:APA91bHC40TCzSsMKRtEWIvgjDcF_bhG3ESAU0Rf2yLRrfoBDOaciUKh-mt1mi2Z2LSUtLg2XVwCCgmNyv1zw6pOlxzKqfQbNCIxCIfdv0FKGKM8VnskKK9e8P0loN2vlTHvHXRM3b9V", forHTTPHeaderField: "Authorization")

        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }

    
}
