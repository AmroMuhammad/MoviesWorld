//
//  MovieDetailsUsecaseContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//

import Foundation
import RxSwift

protocol MovieDetailsUsecaseContract {
    var dataObservable: Observable<MovieDetailsModel> {get}
    var errorObservable: Observable<(String)>{get}
    var loadingObservable: Observable<Bool> {get}
    func fetchData(id: Int)
}
