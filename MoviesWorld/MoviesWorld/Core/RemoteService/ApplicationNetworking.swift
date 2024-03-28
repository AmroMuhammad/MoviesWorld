//
//  ApplicationAPI.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import Alamofire

enum ApplicationNetworking{
    case getMovies(page:String, language: String)
}

extension ApplicationNetworking : TargetType{
    var baseURL: String {
        switch self{
        default:
            return Constants.APIConstatnts.baseURL
        }
    }
    
    var path: String {
        switch self{
        case .getMovies:
            return Constants.APIConstatnts.urlPath
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
        case .getMovies(let page, let language):
            return .requestParameters(parameters:
                                        [Constants.APIConstatnts.includeAdults:false,
                                         Constants.APIConstatnts.includeVideo:false,
                                         Constants.APIConstatnts.language:language,
                                         Constants.APIConstatnts.page:page,
                                         Constants.APIConstatnts.sortBy:Constants.APIConstatnts.popularityDesc
                                        ],
                                      encoding: URLEncoding.default)
        }
    }
    var headers: [String : String]? {
        switch self{
        default:
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": Bundle.main.TMDBKey
            ]
        }
    }
}
