//
//  RegisterRepositoryContract.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

protocol RegisterRepositoryContract {
    func register(user: UserModel, completion: @escaping (Result<Void,NSError>) -> Void)
}
