//
//  LoginScreenAnalyticEventImplementation.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

struct LoginScreenAnalyticEventImplementation: AnalyticsEventContract {
    var eventName: String = ""
    var eventParameters: [String : String] = [:]
    
    mutating func loginClicked() {
        eventName = EventNames.userLogin
    }
}
