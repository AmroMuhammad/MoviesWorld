//
//  LoginRepositoryImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

class LoginRepositoryImp: LoginRepositoryContract {
    let remoteDatasource: LoginRemoteDataSourceContract
    
    init(remoteDatasource: LoginRemoteDataSourceContract) {
        self.remoteDatasource = remoteDatasource
    }
    
    func loginUsing(user: UserModel, completion: @escaping (Result<Void, NSError>) -> Void) {
        remoteDatasource.loginUsing(user: user, completion:completion)
    }
}
