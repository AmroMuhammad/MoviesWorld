//
//  MoviesRepositoryImp.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 24/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MoviesRepositoryImp: MoviesRepositoryContract{
    private var errorsubject = PublishSubject<String>()
    private var loadingsubject = PublishSubject<Bool>()
    private var dataSubject = PublishSubject<[Movie]>()
    private var moviesRemoteDatasource:MoviesRemoteDatasourceContract!
    private var disposeBag:DisposeBag
    private var pageCounter = 1
    private var isPaginationRequestStillResume = false
    private var isRefreshRequstStillResume = false
    private let language = Locale.preferredLanguages[0]
    private let localUserDefaults: LocalUserDefaultsContract
    
    var fetchMoreDatas: PublishSubject<Void>
    var refreshControlCompelted: PublishSubject<Void>
    var isLoadingSpinnerAvaliable: PublishSubject<Bool>
    var refreshControlAction: PublishSubject<Void>
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var dataObservable:Observable<[Movie]>
    var items: BehaviorRelay<[Movie]>
    
    init(
        MoviesRemoteDatasource: MoviesRemoteDatasourceContract,
        localUserDefaults: LocalUserDefaultsContract = LocalUserDefaults.sharedInstance
    ) {
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        dataObservable = dataSubject.asObservable()
        items = BehaviorRelay<[Movie]>(value: [])
        
        fetchMoreDatas = PublishSubject<Void>()
        refreshControlAction = PublishSubject<Void>()
        refreshControlCompelted = PublishSubject<Void>()
        isLoadingSpinnerAvaliable = PublishSubject<Bool>()
        
        self.moviesRemoteDatasource = MoviesRemoteDatasource
        self.localUserDefaults = localUserDefaults
        disposeBag = DisposeBag()
        
        bind()
    }
    
    private func bind() {
        fetchMoreDatas.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.fetchData(page: self.pageCounter,
                           isRefreshControl: false)
        }
        .disposed(by: disposeBag)
        
        refreshControlAction.subscribe { [weak self] _ in
            self?.refreshControlTriggered()
        }
        .disposed(by: disposeBag)
    }
    
    private func refreshControlTriggered() {
        moviesRemoteDatasource.cancelAllRequests()
        pageCounter = 1
        fetchData(page: pageCounter,
                  isRefreshControl: true)
    }
    
    
    private func fetchData(page: Int, isRefreshControl: Bool) {
        self.loadingsubject.onNext(true)
        if isPaginationRequestStillResume || isRefreshRequstStillResume {
            return
        }
        self.isRefreshRequstStillResume = isRefreshControl
        
        isPaginationRequestStillResume = true
        isLoadingSpinnerAvaliable.onNext(true)
        
        if pageCounter == 1  || isRefreshControl {
            isLoadingSpinnerAvaliable.onNext(false)
        }
        
        moviesRemoteDatasource.getMovies(page: String(pageCounter), language: language) {[weak self] (result) in
            guard let self = self else{
                print("PVM* getMovies failed")
                return
            }
            self.loadingsubject.onNext(false)
            switch result{
            case .success(let movies):
                print("2")
                self.handleData(data: movies)
            case .failure(let error):
                self.errorsubject.onNext(error.localizedDescription)
            }
            self.isLoadingSpinnerAvaliable.onNext(false)
            self.isPaginationRequestStillResume = false
            self.isRefreshRequstStillResume = false
            self.refreshControlCompelted.onNext(())
        }
    }
    
    private func handleData(data: [Movie]?) {
        print("in handle data")
        var newData = data
        if pageCounter != 1 {
            print("HD* pc !=1")
            let oldDatas = items.value
            newData = oldDatas + (newData ?? [])
        }
        self.items.accept(newData ?? [])
        self.dataSubject.onNext(newData ?? [])
        pageCounter += 1
    }
    
    func logout() {
        switch localUserDefaults.loginType() {
        case .email:
            firebaseLogout()
        case .google:
            googleLogout()
        }
        localUserDefaults.changeLoggingState(loginState: false, loginType: .email)
    }
    
    private func googleLogout() {
        moviesRemoteDatasource.googleLogout()
    }
    
    private func firebaseLogout() {
        try! moviesRemoteDatasource.firebaseLogout()
    }
}
