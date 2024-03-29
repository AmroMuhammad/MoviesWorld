//
//  SplashScreenViewModel.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

class SplashScreenViewModel: SplashViewModelContract {
    private let userDefaults: LocalUserDefaultsContract
    var coordinator: CoordinatorProtocol
    
    init(coordinator: CoordinatorProtocol, userDefaults: LocalUserDefaultsContract = LocalUserDefaults.sharedInstance) {
        self.coordinator = coordinator
        self.userDefaults = userDefaults
    }
    
    func navigateTo(to: DestinationScreens) {
        coordinator.navigateToNextScreen(destination: to)
    }
    
    func loadAnalyticsSercies() {
        Injector.setupRemoteConfig { [weak self] in
            guard let self = self else {return}
            Injector.addAnalyticProviders()
            self.checkForLoggingState()
        }
    }
    
    private func checkForLoggingState() {
        if(LocalUserDefaults.sharedInstance.isLoggedIn()){
            self.navigateTo(to: .Home)
        }else {
            self.navigateTo(to: .Login)
        }
    }
}
