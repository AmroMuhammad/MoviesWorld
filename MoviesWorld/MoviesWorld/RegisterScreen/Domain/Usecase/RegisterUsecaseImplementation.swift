//
//  RegisterUsecaseImplementation.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

class RegisterUsecaseImplementation : RegisterUsecaseContract {
    
    let repo: RegisterRepositoryContract
    
    init(repo: RegisterRepositoryContract) {
        self.repo = repo
    }
    
//    func fetchUser(byPhoneNumber phone: String, completion: @escaping (Result<User, NSError>) -> Void) {
//        repo.fetchUser(byPhoneNumber: phone, completion: completion)
//    }
//    
//    func save(user: User, completion: @escaping (Result<Bool, NSError>) -> Void) {
//        repo.save(user: user, completion: completion)
//    }
}
