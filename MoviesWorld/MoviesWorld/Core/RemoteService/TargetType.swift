//
//  TargetType.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod : String {  //to map alamofire http methods so if there any change in alamofire I will change here only
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task { //wrapper for my reqeust parameter
    case requestPlain
    case requestParameters(parameters:[String:Any],encoding: ParameterEncoding )
}

protocol TargetType { //wrapper that carries request properties
    var baseURL : String {get}
    var path: String {get}
    var method:HTTPMethod {get}
    var task:Task {get}
    var headers: [String:String]? {get}
}
