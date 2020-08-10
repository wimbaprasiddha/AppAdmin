//
//  UIAplication+extension.swift
//  split-bills
//
//  Created by Willa on 24/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import UIKit

extension UIApplication{
    
    static func switchRootViewController(_ vc: UIViewController){
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        if let windowScenedelegate = scene?.delegate as? SceneDelegate {
            let window = UIWindow(windowScene: scene!)
            window.rootViewController = vc
            windowScenedelegate.window = window
            window.makeKeyAndVisible()
        }
    }
    
}
