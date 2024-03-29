//
//  MovieDetailsRepositoryImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//

import Foundation

import Foundation
import RxSwift
import RxRelay

class MovieDetailsRepositoryImp: MovieDetailsRepositoryContract {
    private var errorsubject = PublishSubject<String>()
    private var loadingsubject = PublishSubject<Bool>()
    private var dataSubject = PublishSubject<MovieDetailsModel>()
    private var movieDetailsRemoteDatasource: MovieDetailsRemoteDatasourceContract
    private let language = Locale.preferredLanguages[0]
    
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var dataObservable:Observable<MovieDetailsModel>
    
    init(movieDetailsRemoteDatasource: MovieDetailsRemoteDatasourceContract) {
        errorObservable = errorsubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        dataObservable = dataSubject.asObservable()

        
        self.movieDetailsRemoteDatasource = movieDetailsRemoteDatasource
    }
    
    func fetchData(id: Int) {
        loadingsubject.onNext(true)
        movieDetailsRemoteDatasource.getMovieDetails(id: id, language: language) {[weak self] result in
            guard let self = self else {return}
            self.loadingsubject.onNext(false)
            switch result {
            case .success(let movieDetails):
                self.dataSubject.onNext(movieDetails)
            case .failure(let error):
                self.errorsubject.onNext(error.localizedDescription)
            }
        }
    }

}
