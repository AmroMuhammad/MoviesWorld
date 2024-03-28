//
//  Constants.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

enum Constants{
    static let isLoggedInUserDefaults = "isLogged"
    static let loginType = "loginType"
    static let emailNotificationDataKey = "email"
    static let movieCellNibName = "MovieTableViewCell"
    static let loginDomain = "com.loginDomain"
    static let registerDomain = "com.registerDomain"
    
    enum APIConstatnts {
        static let baseURL = "https://api.themoviedb.org/3/"
        static let urlPath = "discover/movie"
        static let includeAdults = "include_adult"
        static let includeVideo = "include_video"
        static let language = "language"
        static let page = "page"
        static let sortBy = "sort_by"
        static let popularityDesc = "popularity.desc"
    }
    
}



struct EventNames {
    static let userLogin = "user_login"
    static let userRegister = "user_register"
    static let movie_selected = "movie_click"
    static let userLogout = "user_logout"
}

struct ParameterNames {
    static let movie_id = "movie_id"
}
