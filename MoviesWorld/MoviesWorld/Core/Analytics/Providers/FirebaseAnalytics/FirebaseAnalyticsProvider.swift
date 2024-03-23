//
//  Providers.swift
//  AnalyticModule
//
//  Created by Amr Muhammad on 23/03/2024.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics

public struct FirebaseAnalyticsProvider: AnalyticsProviderContract {
    
    init() {
//        setup()
    }
    
//    func setup() {
//        FirebaseApp.configure()
//    }
    
    public func reportEvent(name: String, parameters: [String: String]) {
        Analytics.logEvent(name, parameters: parameters)
    }
}
