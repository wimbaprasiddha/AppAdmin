//
//  ViewRouter.swift
//  split-bills
//
//  Created by wimba prasiddha on 24/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    @Published var initialPage: AnyView

    private var userDefault: UserDefaults  = UserDefaults.standard
    
    init() {
        
        if userDefault.bool(forKey: UserDefaultKey.onLoginPage.rawValue) == true{
            initialPage = AnyView(LoginScreen())
        }else{
            initialPage = AnyView(OnboardingView())
        }
        
        
        if userDefault.bool(forKey: UserDefaultKey.isUserLoggedIn.rawValue) == true{
            initialPage = AnyView(HomePage())
        }
        
    }
    
    func changeToHome(_ binder: Published<Bool>){
        
    }
    
    
}

