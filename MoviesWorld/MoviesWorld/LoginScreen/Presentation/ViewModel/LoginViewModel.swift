//
//  LoginViewModel.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.

import Foundation
import RxSwift
import GoogleSignIn

class LoginViewModel : LoginViewModelContract{
    private var errorSubject = PublishSubject<(String)>()
    private var loadingSubject = PublishSubject<Bool>()
    private var signedInSubject = PublishSubject<Bool>()
    private let usecase: LoginUseCaseContract
    private let analyticsService: AnalyticsServiceContract
    private var analyticEvent = LoginScreenAnalyticEventImplementation()
    private let userDefaults: LocalUserDefaultsContract
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var signedInObservable: Observable<Bool>
    var coordinator: CoordinatorProtocol
    
    init(
        coordinator: CoordinatorProtocol,
        usecase: LoginUseCaseContract,
        analyticsService: AnalyticsServiceContract,
        userDefaults: LocalUserDefaultsContract = LocalUserDefaults.sharedInstance) {
            self.coordinator = coordinator
            self.usecase = usecase
            self.analyticsService = analyticsService
            self.userDefaults = userDefaults
            errorObservable = errorSubject.asObservable()
            loadingObservable = loadingSubject.asObservable()
            signedInObservable = signedInSubject.asObservable()
        }
    
    func validateInputs(email: String, password: String) {
        loadingSubject.onNext(true)
        if(email.isEmpty || password.isEmpty){
            errorSubject.onNext(Localize.General.emptyFieldsError)
        }else if(!Utils.emailRegex(text: email)){
            errorSubject.onNext(Localize.General.emailError)
        }else if(password.count <= 6){
            errorSubject.onNext(Localize.General.passwordError)
        }else{
            loginUsingEmail(user: UserModel(email: email, password: password))
        }
        loadingSubject.onNext(false)
    }
    
    func loginUsingGmail(with viewController: UIViewController) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) {[weak self] signInResult, error in
            guard let self = self else {return}
            if let error = error {
                self.errorSubject.onNext(error.localizedDescription)
            } else {
                self.analyticEvent.loginClicked()
                self.analyticsService.report(event: self.analyticEvent)
                self.signedInSubject.onNext(true)
                self.userDefaults.changeLoggingState(loginState: true, loginType: .google)
            }
        }
    }
    
    private func loginUsingEmail(user: UserModel) {
        loadingSubject.onNext(true)
        usecase.loginUsing(user: user) {[weak self] result in
            guard let self = self else {return}
            self.loadingSubject.onNext(false)
            switch result {
            case .success():
                self.analyticEvent.loginClicked()
                self.analyticsService.report(event: self.analyticEvent)
                self.signedInSubject.onNext(true)
                self.userDefaults.changeLoggingState(loginState: true, loginType: .email)
            case .failure(let error):
                self.errorSubject.onNext(error.localizedDescription)
            }
        }
    }
    
    func navigateTo(to: DestinationScreens) {
        coordinator.navigateToNextScreen(destination: to)
    }
}
