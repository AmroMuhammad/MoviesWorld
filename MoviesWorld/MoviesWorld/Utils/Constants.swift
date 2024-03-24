//
//  Constants.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation

struct Constants{
    static let isLoggedInUserDefaults = "isLogged"
    static let loginType = "loginType"
    static let baseURL = ""
    static let urlPath = "v2/list"
    static let id = "id"
    static let author = "author"
    static let width = "width"
    static let height = "height"
    static let url = "url"
    static let downloadURL = "downloadURL"
    static let emailNotificationDataKey = "email"
}


struct EventNames {
    static let userLogin = "user_login"
    static let userRegister = "user_register"
    static let product_selected = "product_click"
    static let userLogout = "user_logout"
}

struct ParameterNames {
    static let product_id = "product_id"
}
