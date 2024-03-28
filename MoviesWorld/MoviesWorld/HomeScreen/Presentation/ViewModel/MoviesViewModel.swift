//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 24/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MoviesViewModel : MoviesViewModelContract{
    var items: BehaviorRelay<[Movie]>
    var fetchMoreDatas: PublishSubject<Void>
    var refreshControlCompelted: PublishSubject<Void>
    var isLoadingSpinnerAvaliable: PublishSubject<Bool>
    var refreshControlAction: PublishSubject<Void>
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var coordinator: CoordinatorProtocol
    private var errorsubject = PublishSubject<String>()
    private var loadingsubject = PublishSubject<Bool>()
    private let analyticsService: AnalyticsServiceContract
    private var analyticEvent = MoviesSreenAnalyticEventImplementation()
    private var disposeBag:DisposeBag
    private let usecase:MoviesUsecasContract
    
    
    init(
        coordinator: CoordinatorProtocol,
        usecase: MoviesUsecasContract,
        analyticsService: AnalyticsServiceContract
    ) {
        self.coordinator = coordinator
        self.usecase = usecase
        self.analyticsService = analyticsService

        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        
        items = BehaviorRelay<[Movie]>(value: [])
        
        fetchMoreDatas = PublishSubject<Void>()
        refreshControlAction = PublishSubject<Void>()
        refreshControlCompelted = PublishSubject<Void>()
        isLoadingSpinnerAvaliable = PublishSubject<Bool>()
        
        disposeBag = DisposeBag()
        
        bind()
    }
    
    func logout() {
        usecase.logout()
    }
    
    private func bind() {
        fetchMoreDatas.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.usecase.fetchMoreDatas.onNext(())
        }
        .disposed(by: disposeBag)
        
        refreshControlAction.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.usecase.refreshControlAction.onNext(())
        }
        .disposed(by: disposeBag)
        
        usecase.dataObservable.subscribe(onNext: {[weak self] (MovieArray) in
            guard let self = self else {return}
            self.items.accept(MovieArray)
        }).disposed(by: disposeBag)
        
        usecase.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else {return}
            self.errorsubject.onNext(message)
        }).disposed(by: disposeBag)
        
        usecase.loadingObservable.subscribe(onNext: {[weak self] (bool) in
            guard let self = self else {return}
            self.loadingsubject.onNext(bool)
        }).disposed(by: disposeBag)
        
        usecase.isLoadingSpinnerAvaliable.subscribe(onNext: {[weak self] (bool) in
            guard let self = self else {return}
            self.isLoadingSpinnerAvaliable.onNext(bool)
        }).disposed(by: disposeBag)
        
        usecase.refreshControlCompelted.subscribe(onNext: {[weak self] (_) in
            guard let self = self else {return}
            self.refreshControlCompelted.onNext(())
        }).disposed(by: disposeBag)
        
    }
    
    func navigateTo(to: DestinationScreens) {
        switch to {
        case .Login:
            analyticEvent.logoutClicked()
            analyticsService.report(event: analyticEvent)
            coordinator.navigateToNextScreen(destination: .Login)
//        case .Details(let model):
//            analyticEvent.productClicked(id: model.id)
//            analyticsService.report(event: analyticEvent)
//            coordinator.navigateToNextScreen(destination: .Details(model))
        default:
            break
        }
    }
}
