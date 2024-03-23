//
//  LoginViewModelContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginViewModelContract : BaseViewModelContract {
    var signedInObservable: Observable<Bool> {get}
    func validateInputs(email: String, password: String)
    func checkForLoggingState()
    var coordinator: CoordinatorProtocol {set get}
}
