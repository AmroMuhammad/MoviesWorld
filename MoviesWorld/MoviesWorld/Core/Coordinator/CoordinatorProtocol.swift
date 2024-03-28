//
//  CoordinatorProtocol.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 12/12/21.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
    func navigateToNextScreen(destination: DestinationScreens)
    func dismiss()
    func navigateToRoot()
}


enum DestinationScreens{
    case Splash
    case Login
    case Register
    case Home
}
