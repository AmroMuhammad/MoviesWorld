//
//  BaseViewModelContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseViewModelContract{
    var errorObservable:Observable<(String)>{get}
    var loadingObservable: Observable<Bool> {get}
    func navigateTo(to: DestinationScreens)
    var coordinator: CoordinatorProtocol {set get}
}
