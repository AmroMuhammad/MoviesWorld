//
//  MovieDetailsRemoteDatasourceImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//

import Foundation
import Alamofire
import FirebaseAuth
import GoogleSignIn

class MovieDetailsRemoteDatasourceImp : BaseAPI<ApplicationNetworking>, MovieDetailsRemoteDatasourceContract {
    
    func getMovieDetails(id: Int, language: String, completion: @escaping (Result<MovieDetailsModel, NSError>) -> Void) {
        self.fetchData(target: .getMovieDetails(id: id, language: language), responseClass: MovieDetailsModel.self) { result in
            switch result {
            case .success(let movieDetails):
                completion(.success(movieDetails!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }    
}
