//
//  MovieDetailsUsecaseImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

class MovieDetailsUsecaseImp: MovieDetailsUsecaseContract {
    private var errorsubject = PublishSubject<String>()
    private var loadingsubject = PublishSubject<Bool>()
    private var dataSubject = PublishSubject<MovieDetailsModel>()
    private var disposeBag: DisposeBag
    private let repo: MovieDetailsRepositoryContract

    var dataObservable: Observable<MovieDetailsModel>
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var fetchMoreDatas: PublishSubject<Void>
    var refreshControlCompelted: PublishSubject<Void>
    var isLoadingSpinnerAvaliable: PublishSubject<Bool>
    var refreshControlAction: PublishSubject<Void>
    
    init(
        repo: MovieDetailsRepositoryContract
    ) {
        self.repo = repo
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        dataObservable = dataSubject.asObservable()
        
        fetchMoreDatas = PublishSubject<Void>()
        refreshControlAction = PublishSubject<Void>()
        refreshControlCompelted = PublishSubject<Void>()
        isLoadingSpinnerAvaliable = PublishSubject<Bool>()
        
        disposeBag = DisposeBag()
        
        bind()
    }
    
    private func bind() {
        repo.dataObservable.subscribe(onNext: {[weak self] (movieDetails) in
            guard let self = self else {return}
            self.dataSubject.onNext(movieDetails)
        }).disposed(by: disposeBag)
        
        repo.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else {return}
            self.errorsubject.onNext(message)
        }).disposed(by: disposeBag)
        
        repo.loadingObservable.subscribe(onNext: {[weak self] (bool) in
            guard let self = self else {return}
            self.loadingsubject.onNext(bool)
        }).disposed(by: disposeBag)
        
    }
    
    func fetchData(id: Int) {
        repo.fetchData(id: id)
    }
        
}
