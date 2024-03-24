//
//  SplashViewModelContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

protocol SplashViewModelContract {
    func navigateTo(to: DestinationScreens)
    var coordinator: CoordinatorProtocol {set get}
    func loadAnalyticsSercies()
}
