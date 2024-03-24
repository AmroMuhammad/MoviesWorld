//
//  ApplicationAPI.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import Foundation
import Alamofire

enum ApplicationNetworking{
    case getMovies(page:String, limit:String)
}

extension ApplicationNetworking : TargetType{
    var baseURL: String {
        switch self{
        default:
            return Constants.baseURL
        }
    }
    
    var path: String {
        switch self{
        case .getMovies:
            return Constants.urlPath
        }
    }
    
    var method: HTTPMethod {
        switch self{
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .getMovies(let page, let limit):
            return .requestParameters(parameters: ["page":page,"limit":limit], encoding: URLEncoding.default)
        }
    }
    var headers: [String : String]? {
        switch self{
        default:
            return ["Accept": "application/json","Content-Type": "application/json"]
        }
    }
}
