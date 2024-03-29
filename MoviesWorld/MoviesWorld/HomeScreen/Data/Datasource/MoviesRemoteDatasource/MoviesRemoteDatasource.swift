//
//  MoviesRemoteDatasource.swift
//  MoviesApp
//
//  Created by Amr Muhammad on 12/10/21.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseAuth
import GoogleSignIn

class MoviesRemoteDatasource : BaseAPI<ApplicationNetworking>, MoviesRemoteDatasourceContract{

    func getMovies(page: String, language: String, completion: @escaping (Result<[Movie]?, NSError>) -> Void) {
        self.fetchData(target: .getMovies(page: page, language: language), responseClass: MoviesModel.self) { (result) in
            switch result {
            case .success(let movieModel):
                completion(.success(movieModel?.movies))
            case .failure(let error):
                completion(.failure(error))

            }
        }
    }
    
    func cancelAllRequests() {
        self.cancelAnyRequest()
    }
    
    func firebaseLogout() throws {
        try Auth.auth().signOut()
    }
    
    func googleLogout() {
        GIDSignIn.sharedInstance.signOut()
    }

}

   
