//
//  LoginRepositoryImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

class LoginRepositoryImp: LoginRepositoryContract {
    let localDataSource: LoginLocalDataSourceContract
    
    init(localDataSource: LoginLocalDataSourceContract) {
        self.localDataSource = localDataSource
    }
    
//    func fetchUser(byPhoneNumber phone: String, completion: @escaping (Result<User, NSError>) -> Void) {
//        localDataSource.fetchUser(byPhoneNumber: phone, completion: completion)
//    }
    
    
}
