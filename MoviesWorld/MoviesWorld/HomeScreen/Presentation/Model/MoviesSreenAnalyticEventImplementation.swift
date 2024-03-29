//
//  MoviesSreenAnalyticEventImplementation.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 15/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

struct MoviesSreenAnalyticEventImplementation: AnalyticsEventContract {
    var eventName: String = ""
    var eventParameters: [String : String] = [:]
    
    mutating func productClicked(id: Int) {
        eventName = EventNames.movie_selected
        eventParameters = [ParameterNames.movie_id : String(id)]
    }
    
    mutating func logoutClicked() {
        eventName = EventNames.userLogout
        eventParameters = [:]
    }
}
