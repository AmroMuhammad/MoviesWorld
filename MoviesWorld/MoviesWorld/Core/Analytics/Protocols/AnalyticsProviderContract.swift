//
//  AnalyticsProviderContract.swift
//  AnalyticModule
//
//  Created by Amr Muhammad on 23/03/2024.
//

import Foundation

public protocol AnalyticsProviderContract {
    func reportEvent(name: String, parameters: [String: String])
}
