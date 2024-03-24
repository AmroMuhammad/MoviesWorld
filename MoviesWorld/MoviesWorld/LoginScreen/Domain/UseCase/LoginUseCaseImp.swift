//
//  LoginUseCaseImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

class LoginUseCaseImp: LoginUseCaseContract {
    let repo: LoginRepositoryContract
    
    init(repo: LoginRepositoryContract) {
        self.repo = repo
    }
    
    func loginUsing(user: UserModel, completion: @escaping (Result<Void, NSError>) -> Void) {
        repo.loginUsing(user: user, completion: completion)
    }
    
}
