//
//  LocalUserDefault.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2024 Amr Muhammad. All rights reserved.
//

import Foundation

protocol LocalUserDefaultsContract {
    func isLoggedIn() -> Bool
    func changeLoggingState(loginState:Bool, loginType: LoginType)
    func loginType() -> LoginType
}

class LocalUserDefaults: LocalUserDefaultsContract {
    static let sharedInstance = LocalUserDefaults()
    private var userDefaults:UserDefaults
    
    private init(){
        userDefaults = UserDefaults.standard
    }
    
    func isLoggedIn() -> Bool {
        let loggedIn = userDefaults.value(forKey: Constants.isLoggedInUserDefaults)
        if(loggedIn != nil){
            if(loggedIn as! Bool){
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func changeLoggingState(loginState:Bool, loginType: LoginType){
        userDefaults.set(loginState, forKey: Constants.isLoggedInUserDefaults)
        userDefaults.set(loginType.rawValue, forKey: Constants.loginType)
    }
    
    func loginType() -> LoginType {
        let loginType = userDefaults.value(forKey: Constants.loginType) as! String
        return LoginType(rawValue: loginType)!
    }
}


