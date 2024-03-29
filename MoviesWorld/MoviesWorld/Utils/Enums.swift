//
//  Enums.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit

enum StoryBoardsEnum : String {
    case Splash = "SplashScreenViewController"
    case Login = "LoginViewController"
    case Register = "RegisterViewController"
    case Movies = "MoviesViewController"
    case Details = "DetailsViewController"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type) ->T {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyBoardID) as! T
    }
}

enum LoginType: String {
    case email
    case google
}
