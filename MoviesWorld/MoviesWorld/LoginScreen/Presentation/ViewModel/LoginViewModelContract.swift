//
//  LoginViewModelContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginViewModelContract : BaseViewModelContract {
    var signedInObservable: Observable<Bool> {get}
    var coordinator: CoordinatorProtocol {set get}
    func validateInputs(email: String, password: String)
    func loginUsingGmail(with viewController: UIViewController)
}
