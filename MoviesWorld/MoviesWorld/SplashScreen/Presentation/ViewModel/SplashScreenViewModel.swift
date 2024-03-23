//
//  SplashScreenViewModel.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

class SplashScreenViewModel: SplashViewModelContract {
    var coordinator: CoordinatorProtocol

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
        //TODO: check for remember me
    }
    
    func navigateTo(to: DestinationScreens) {
        coordinator.navigateToNextScreen(destination: to)
    }
    
    func loadAnalyticsSercies() {
        Injector.setupRemoteConfig { [weak self] in
            guard let self = self else {return}
            Injector.addAnalyticProviders()
            self.navigateTo(to: .Login)
        }
    }
}
