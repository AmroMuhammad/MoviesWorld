//
//  DetailsViewModel.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class DetailsViewModel : DetailsViewModelContract {
    var dataObservable: Observable<MovieDetailsModel>
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var coordinator: CoordinatorProtocol
    var id: Int
    
    private var dataSubject = PublishSubject<MovieDetailsModel>()
    private var errorSubject = PublishSubject<String>()
    private var loadingSubject = PublishSubject<Bool>()
    private let usecase: MovieDetailsUsecaseContract
    private let disposeBag: DisposeBag

    init(id: Int, usecase: MovieDetailsUsecaseContract, coordinator: CoordinatorProtocol) {
        self.usecase = usecase
        self.id = id
        self.coordinator = coordinator
        dataObservable = dataSubject.asObservable()
        errorObservable = errorSubject.asObservable()
        loadingObservable = loadingSubject.asObservable()
        disposeBag = DisposeBag()
        bind()
    }
    
    private func bind() {
        usecase.dataObservable.subscribe(onNext: {[weak self] (movieDetails) in
            guard let self = self else {return}
            self.dataSubject.onNext(movieDetails)
        }).disposed(by: disposeBag)
        
        usecase.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else {return}
            self.errorSubject.onNext(message)
        }).disposed(by: disposeBag)
        
        usecase.loadingObservable.subscribe(onNext: {[weak self] (bool) in
            guard let self = self else {return}
            self.loadingSubject.onNext(bool)
        }).disposed(by: disposeBag)
        
    }
    
    func navigateTo(to: DestinationScreens) {
        coordinator.dismiss()
    }
    
    func fetchMovieDetails() {
        usecase.fetchData(id: id)
    }
}

