//
//  SplashScreenViewController.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var movieLabel: UILabel!
    var viewModel: SplashViewModelContract!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadAnalyticsSercies()
        welcomeLabel.text = Localize.Splash.welcomeTo
        movieLabel.text = Localize.appName
        
    }
}
