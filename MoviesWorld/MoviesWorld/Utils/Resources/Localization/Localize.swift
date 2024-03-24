//
//  Localize.swift
//  IPNFramework
//
//  Created by Amr Muhammad on 25/12/2023.
//

import Foundation

enum Localize {
    static let appName = "appName".localize

    enum General {
        static let genericError = "genericError".localize
        static let alertTitle = "alertTitle".localize
        static let ok = "ok".localize
        static let emptyFieldsError = "emptyFieldsError".localize
        static let emailError = "emailError".localize
        static let passwordError = "passwordError".localize
        static let passwordNotEqualError = "passwordNotEqualError".localize
        static let loginPasswordError = "loginPasswordError".localize
        static let noInternetConnection = "noInternetConnection".localize
        static let accountAlreadyExist = "accountAlreadyExist".localize
        static let email = "email".localize
        static let password = "password".localize
        static let signup = "signup".localize
    }
    
    enum Splash {
        static let welcomeTo = "welcome_to".localize
    }
    
    enum Login {
        static let loginTo = "login_to".localize
        static let login = "login".localize
        static let continueWith = "continue_with".localize
        static let dontHave = "dont_have".localize
    }
    
    enum Register {
        static let confirmPassword = "confirm_password".localize
        static let register = "register".localize

    }
}
