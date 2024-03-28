//
//  MoviesUsecasContract.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 15/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviesUsecasContract: PaginationContract{
    var dataObservable:Observable<[Movie]> {get}
    var errorObservable:Observable<(String)>{get}
    var loadingObservable: Observable<Bool> {get}
    func logout()
}
