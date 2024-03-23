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
    
//    func fetchUser(byPhoneNumber phone: String, completion: @escaping (Result<User, NSError>) -> Void) {
//        repo.fetchUser(byPhoneNumber: phone, completion: completion)
//    }
//    
    
}
