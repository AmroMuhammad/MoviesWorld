//
//  MoviesUsecaseImp.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 15/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

class MoviesUsecaseImp: MoviesUsecasContract {
    private var errorsubject = PublishSubject<String>()
    private var loadingsubject = PublishSubject<Bool>()
    private var dataSubject = PublishSubject<[Movie]>()
    private var disposeBag:DisposeBag
    private let repo: MoviesRepositoryContract
    private let localUserDefaults: LocalUserDefaultsContract

    var dataObservable: Observable<[Movie]>
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var items: BehaviorRelay<[Movie]>
    var fetchMoreDatas: PublishSubject<Void>
    var refreshControlCompelted: PublishSubject<Void>
    var isLoadingSpinnerAvaliable: PublishSubject<Bool>
    var refreshControlAction: PublishSubject<Void>
    
    init(
        repo: MoviesRepositoryContract,
         localUserDefaults: LocalUserDefaultsContract = LocalUserDefaults.sharedInstance
    ) {
        self.repo = repo
        self.localUserDefaults = localUserDefaults
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        dataObservable = dataSubject.asObservable()
        items = BehaviorRelay<[Movie]>(value: [])
        
        fetchMoreDatas = PublishSubject<Void>()
        refreshControlAction = PublishSubject<Void>()
        refreshControlCompelted = PublishSubject<Void>()
        isLoadingSpinnerAvaliable = PublishSubject<Bool>()
        
        disposeBag = DisposeBag()
        
        bind()
    }
    
    private func bind() {
        fetchMoreDatas.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.repo.fetchMoreDatas.onNext(())
        }
        .disposed(by: disposeBag)
        
        refreshControlAction.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.repo.refreshControlAction.onNext(())
        }
        .disposed(by: disposeBag)
        
        repo.dataObservable.subscribe(onNext: {[weak self] (MovieArray) in
            guard let self = self else {return}
            self.items.accept(MovieArray)
            self.dataSubject.onNext(MovieArray)
        }).disposed(by: disposeBag)
        
        repo.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else {return}
            self.errorsubject.onNext(message)
        }).disposed(by: disposeBag)
        
        repo.loadingObservable.subscribe(onNext: {[weak self] (bool) in
            guard let self = self else {return}
            self.loadingsubject.onNext(bool)
        }).disposed(by: disposeBag)
        
        repo.isLoadingSpinnerAvaliable.subscribe(onNext: {[weak self] (bool) in
            guard let self = self else {return}
            self.isLoadingSpinnerAvaliable.onNext(bool)
        }).disposed(by: disposeBag)
        
        repo.refreshControlCompelted.subscribe(onNext: {[weak self] (_) in
            guard let self = self else {return}
            self.refreshControlCompelted.onNext(())
        }).disposed(by: disposeBag)
        
    }
    
    func logout() {
        repo.logout()
    }
        
}
