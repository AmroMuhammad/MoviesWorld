//
//  RegisterRemoteDatasourceImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth


class RegisterRemoteDatasourceImp: RegisterRemoteDatasourceContract {
    
    func register(user: UserModel, completion: @escaping (Result<Void, NSError>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error as? NSError {
                switch AuthErrorCode(_nsError: error).code {
                case .operationNotAllowed:
                    let error = NSError(domain: Constants.registerDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.genericError])
                    completion(.failure(error))
                case .emailAlreadyInUse:
                    let error = NSError(domain: Constants.registerDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.accountAlreadyExist])
                    completion(.failure(error))
                case .invalidEmail:
                    let error = NSError(domain: Constants.registerDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.emailError])
                    completion(.failure(error))
                case .weakPassword:
                    let error = NSError(domain: Constants.registerDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.passwordError])
                    completion(.failure(error))
                default:
                    let error = NSError(domain: Constants.registerDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: Localize.General.genericError])
                    completion(.failure(error))
                }
            } else {
                print("User signs up successfully")
                completion(.success(()))
            }
        }
    }
}
