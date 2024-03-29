//
//  File.swift
//  AnalyticModule
//
//  Created by Amr Muhammad on 23/03/2024.
//

import Foundation

public final class AnalyticsService: AnalyticsServiceContract {
    private static var providers = [AnalyticsProviderContract]()
    
    static let shared = AnalyticsService(providers: providers)
    
    private init(providers: [AnalyticsProviderContract]) {
        AnalyticsService.providers = providers
    }
    
    static func register(provider: AnalyticsProviderContract) {
        providers.append(provider)
    }
    
    func report(event: AnalyticsEventContract) {
        AnalyticsService.providers.forEach {
            $0.reportEvent(name: event.eventName, parameters: event.eventParameters)
        }
    }
}
