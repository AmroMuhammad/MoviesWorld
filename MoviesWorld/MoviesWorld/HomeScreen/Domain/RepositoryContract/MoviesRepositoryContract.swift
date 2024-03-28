//
//  MoviesRepositoryContract.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 24/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviesRepositoryContract : PaginationContract{
    var errorObservable:Observable<(String)>{get}
    var loadingObservable: Observable<Bool> {get}
    var dataObservable:Observable<[Movie]> {get}
    func logout()
}
