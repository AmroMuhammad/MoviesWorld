//
//  AppCoordinator.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 12/12/21.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit


class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let nextViewController = Injector.getSplashViewController(coordinator: self)
        navigationController.pushViewController(nextViewController, animated: false)
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: true)
        }
    }
    
    func navigateToRoot() {
        DispatchQueue.main.async {
            self.navigationController.popToRootViewController(animated: true)
            self.navigationController.dismiss(animated: true)
        }
    }
            
    func navigateToNextScreen(destination: DestinationScreens){
        switch destination{
        case .Splash:
            start()
        case .Login:
            openLoginScreen()
        case .Register:
            openRegisterScreen()
        case .Home:
            openMoviesScreen()
        case .Details(let id):
            openMovieDetailsScreen(id: id)
        }
        
    }
    
    private func openLoginScreen() {
        let nextViewController = Injector.getLoginViewController(coordinator: self)
        navigationController.pushViewController(nextViewController, animated: false)
    }
    
    private func openRegisterScreen() {
        let nextViewController = Injector.getRegisterViewController(coordinator: self)
        navigationController.pushViewController(nextViewController, animated: false)
    }
    
    private func openMoviesScreen() {
        let nextViewController = Injector.getMoviesViewController(coordinator: self)
        navigationController.pushViewController(nextViewController, animated: false)
    }
    
    private func openMovieDetailsScreen(id: Int) {
        let nextViewController = Injector.getMovieDetailsViewController(coordinator: self, id: id)
        navigationController.pushViewController(nextViewController, animated: false)
    }
}
