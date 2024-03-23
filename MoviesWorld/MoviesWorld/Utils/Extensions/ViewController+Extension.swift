//
//  ViewController+Extension.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiateFromStoryBoard(appStoryBoard : StoryBoardsEnum) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    class var storyboardID : String {
        return "\(self)"
    }

}
