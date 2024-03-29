//
//  MovieDetailsRemoteDatasourceContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 28/03/2024.
//

import Foundation

protocol MovieDetailsRemoteDatasourceContract {
    func getMovieDetails(id: Int, language: String, completion: @escaping (Result<MovieDetailsModel, NSError>) -> Void)
}
