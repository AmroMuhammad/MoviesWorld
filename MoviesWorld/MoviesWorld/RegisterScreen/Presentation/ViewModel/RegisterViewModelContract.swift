//
//  RegisterViewModelContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

protocol RegisterViewModelContract: BaseViewModelContract {
    func validateInputData(email: String, password: String, confirmPassword: String)
    var doneObservable: Observable<Void>{get}
    var coordinator: CoordinatorProtocol {set get}
}
