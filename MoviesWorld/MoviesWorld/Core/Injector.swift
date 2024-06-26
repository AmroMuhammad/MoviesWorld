//
//  Injector.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit

class Injector {
    
    static func getSplashViewController(coordinator: CoordinatorProtocol) -> SplashScreenViewController {
        let viewModel = SplashScreenViewModel(coordinator: coordinator)
        let viewcontroller = SplashScreenViewController.instantiateFromStoryBoard(appStoryBoard: .Splash)
        viewcontroller.viewModel = viewModel
        return viewcontroller
    }
    
    static func getLoginViewController(coordinator: CoordinatorProtocol) -> LoginViewController {
        let remoteDatasource = LoginRemoteDataSourceImp()
        let repo = LoginRepositoryImp(remoteDatasource: remoteDatasource)
        let usecase = LoginUseCaseImp(repo: repo)
        let viewModel = LoginViewModel(coordinator: coordinator, usecase: usecase, analyticsService: AnalyticsService.shared)
        let viewcontroller = LoginViewController.instantiateFromStoryBoard(appStoryBoard: .Login)
        viewcontroller.loginViewModel = viewModel
        return viewcontroller
    }
    
    static func getRegisterViewController(coordinator: CoordinatorProtocol) -> RegisterViewController {
        
        let remoteDatasource = RegisterRemoteDatasourceImp()
        let repo = RegisterRepositoryImp(remoteDatasource: remoteDatasource)
        let usecase = RegisterUsecaseImp(repo: repo)
        let viewModel = RegisterViewModel(coordinator: coordinator, usecase: usecase, analyticsService: AnalyticsService.shared)
        let viewcontroller = RegisterViewController.instantiateFromStoryBoard(appStoryBoard: .Register)
        viewcontroller.registerViewModel = viewModel
        return viewcontroller
    }
    
    static func getMoviesViewController(coordinator: CoordinatorProtocol) -> MoviesViewController {
        let remoteDatasource = MoviesRemoteDatasource()
        let repo = MoviesRepositoryImp(MoviesRemoteDatasource: remoteDatasource)
        let usecase = MoviesUsecaseImp(repo: repo)
        let viewModel = MoviesViewModel(coordinator: coordinator, usecase: usecase, analyticsService: AnalyticsService.shared)
        let viewcontroller = MoviesViewController.instantiateFromStoryBoard(appStoryBoard: .Movies)
        viewcontroller.moviesViewModel = viewModel
        return viewcontroller
    }
    
    static func getMovieDetailsViewController(coordinator: CoordinatorProtocol, id: Int) -> DetailsViewController {
        let remoteDatasource = MovieDetailsRemoteDatasourceImp()
        let repo = MovieDetailsRepositoryImp(movieDetailsRemoteDatasource: remoteDatasource)
        let usecase = MovieDetailsUsecaseImp(repo: repo)
        let viewModel = DetailsViewModel(id: id, usecase: usecase, coordinator: coordinator)
        let viewcontroller = DetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Details)
        viewcontroller.detailsViewModel = viewModel
        return viewcontroller
    }
    
    static func addFirebaseAnalytic() {
        if (RemoteConfigService.shared.bool(for: .enableFirebaseAnalytics)){
            AnalyticsService.register(provider: FirebaseAnalyticsProvider())
        }
    }
    
    static func addMixPanelAnalytic() {
        if (RemoteConfigService.shared.bool(for: .enableMixPanelAnalytics)){
            AnalyticsService.register(provider: MixPanelAnalyticsProvider())
        }
    }
    
    static func setupRemoteConfig(completion: @escaping () -> Void) {
        RemoteConfigService.shared.setup(completion: completion)
    }
    
    static func addAnalyticProviders() {
        self.addFirebaseAnalytic()
        self.addMixPanelAnalytic()
    }
}
