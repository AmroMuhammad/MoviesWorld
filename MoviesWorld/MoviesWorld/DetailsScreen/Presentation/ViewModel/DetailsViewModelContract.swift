//
//  DetailsViewModelContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol DetailsViewModelContract: BaseViewModelContract{
    var dataObservable:Observable<MovieDetailsModel>{get}
    func fetchMovieDetails()
}
