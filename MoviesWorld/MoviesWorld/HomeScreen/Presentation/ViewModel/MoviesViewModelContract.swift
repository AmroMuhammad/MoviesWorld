//
//  MoviesViewModelContract.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 24/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol MoviesViewModelContract : BaseViewModelContract,PaginationContract {
    var items: BehaviorRelay<[Movie]> {get set}
    func logout()
}
