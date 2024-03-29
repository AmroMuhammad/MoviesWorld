//
//  RegisterUsecaseImp.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

class RegisterUsecaseImp: RegisterUsecaseContract {
    
    let repo: RegisterRepositoryContract
    
    init(repo: RegisterRepositoryContract) {
        self.repo = repo
    }
    
    func register(user: UserModel, completion: @escaping (Result<Void, NSError>) -> Void) {
        repo.register(user: user, completion: completion)
    }
}
