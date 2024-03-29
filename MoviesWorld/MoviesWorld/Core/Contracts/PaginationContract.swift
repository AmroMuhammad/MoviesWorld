//
//  PaginationContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 12/12/21.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
protocol PaginationContract {
    var items: BehaviorRelay<[Movie]> {get}
    var fetchMoreDatas: PublishSubject<Void> {get}
    var refreshControlCompelted : PublishSubject<Void> {get}
    var isLoadingSpinnerAvaliable : PublishSubject<Bool> {get}
    var refreshControlAction : PublishSubject<Void> {get}
}
