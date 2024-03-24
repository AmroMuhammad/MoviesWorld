//
//  RegisterRepositoryImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

class RegisterRepositoryImp: RegisterRepositoryContract {
    
    let remoteDatasource: RegisterRemoteDatasourceContract
    
    init(remoteDatasource: RegisterRemoteDatasourceContract) {
        self.remoteDatasource = remoteDatasource
    }
    
    func register(user: UserModel, completion: @escaping (Result<Void, NSError>) -> Void) {
        remoteDatasource.register(user: user, completion: completion)
    }
    
//    func fetchUser(byPhoneNumber phone: String, completion: @escaping (Result<User, NSError>) -> Void) {
//        localDataSource.fetchUser(byPhoneNumber: phone, completion: completion)
//    }
//    
//    func save(user: User, completion: @escaping (Result<Bool, NSError>) -> Void) {
//        localDataSource.save(user: user, completion: completion)
//    }
}
