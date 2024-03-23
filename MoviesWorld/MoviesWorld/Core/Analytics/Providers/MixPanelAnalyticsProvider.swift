//
//  MixPanelAnalyticsProvider.swift
//  AnalyticModule
//
//  Created by Amr Muhammad on 23/03/2024.
//

import Foundation
import Mixpanel

public struct MixPanelAnalyticsProvider: AnalyticsProviderContract {
    
    init() {
        setup()
    }
    
    func setup() {
        Mixpanel.initialize(token: Bundle.main.mixPanelKey, trackAutomaticEvents: false)
    }
   
    public func reportEvent(name: String, parameters: [String: String]) {
        Mixpanel.mainInstance().track(event: name, properties: parameters)
    }
}
