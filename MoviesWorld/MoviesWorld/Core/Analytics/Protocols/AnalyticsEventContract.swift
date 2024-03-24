//
//  AnalyticsEventContract.swift
//  AnalyticModule
//
//  Created by Amr Muhammad on 23/03/2024.
//

import Foundation

public protocol AnalyticsEventContract {
    var eventName: String { get set }
    var eventParameters: [String: String] { get set }
}
