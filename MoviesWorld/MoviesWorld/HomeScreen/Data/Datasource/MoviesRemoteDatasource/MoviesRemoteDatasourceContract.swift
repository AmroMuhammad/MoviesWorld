//
//  MoviesRemoteDatasourceContract.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 24/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
protocol MoviesRemoteDatasourceContract {
    func getMovies(page: String, language: String, completion: @escaping (Result<[Movie]?,NSError>) -> Void)
    func cancelAllRequests()
    func firebaseLogout() throws
    func googleLogout()
}
