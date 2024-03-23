//
//  LoginViewModel.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.

import Foundation
import RxSwift

class LoginViewModel : LoginViewModelContract{
    private var errorSubject = PublishSubject<(String)>()
    private var loadingSubject = PublishSubject<Bool>()
    private var signedInSubject = PublishSubject<Bool>()
    private let usecase: LoginUseCaseContract
    private let analyticsService: AnalyticsServiceContract
    private var analyticEvent = LoginScreenAnalyticEventImplementation()
    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var signedInObservable: Observable<Bool>
    var coordinator: CoordinatorProtocol
    
    init(coordinator: CoordinatorProtocol, usecase: LoginUseCaseContract, analyticsService: AnalyticsServiceContract) {
        self.coordinator = coordinator
        self.usecase = usecase
        self.analyticsService = analyticsService
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
        }else if(password.count <= 5){
            errorSubject.onNext(Localize.General.passwordError)
        }else{
            //login
        }
        loadingSubject.onNext(false)
        analyticEvent.loginClicked()
        analyticsService.report(event: analyticEvent)
    }
    

    
    func checkForLoggingState() {
        loadingSubject.onNext(true)
        if(LocalUserDefaults.sharedInstance.isLoggedIn()){
            self.signedInSubject.onNext(true)
        }
        loadingSubject.onNext(false)
    }
    
    func navigateTo(to: DestinationScreens) {
        coordinator.navigateToNextScreen(destination: to)
    }
}
