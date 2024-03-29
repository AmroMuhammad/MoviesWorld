//
//  LoginRemoteDataSourceImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class LoginRemoteDataSourceImp: LoginRemoteDataSourceContract {
    func loginUsing(user: UserModel, completion: @escaping (Result<Void, NSError>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error as? NSError {
                switch AuthErrorCode(_nsError: error).code {
                case .userDisabled:
                    let error = NSError(domain: Constants.loginDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.userDisabled])
                    completion(.failure(error))
                case .wrongPassword, .invalidEmail:
                    let error = NSError(domain: Constants.loginDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.loginPasswordError])
                    completion(.failure(error))
                case .operationNotAllowed:
                    let error = NSError(domain: Constants.loginDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.genericError])
                    completion(.failure(error))
                case .userNotFound:
                    let error = NSError(domain: Constants.loginDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.userNotFound])
                    completion(.failure(error))
                default:
                    let error = NSError(domain: Constants.loginDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.genericError])
                    completion(.failure(error))
                }
            } else {
                print("User signs in successfully")
                completion(.success(()))
            }
        }
    }
    
}
