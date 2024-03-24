//
//  RegisterViewModel.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.


import Foundation
import RxSwift

class RegisterViewModel:RegisterViewModelContract {
    private var errorSubject = PublishSubject<(String)>()
    private var loadingsubject = PublishSubject<Bool>()
    private var doneSubject = PublishSubject<Void>()
    private let analyticsService: AnalyticsServiceContract
    private var analyticEvent = RegisterScreenAnalyticEventImplementation()

    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
    var doneObservable: Observable<Void>
    var coordinator: CoordinatorProtocol
    let usecase: RegisterUsecaseContract
    
    init(coordinator: CoordinatorProtocol, usecase: RegisterUsecaseContract, analyticsService: AnalyticsServiceContract) {
        self.coordinator = coordinator
        self.usecase = usecase
        self.analyticsService = analyticsService
        errorObservable = errorSubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
        doneObservable = doneSubject.asObservable()
    }
    
    func validateInputData(email: String, password: String, confirmPassword: String){
        loadingsubject.onNext(true)
        if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
            errorSubject.onNext(Localize.General.emptyFieldsError)
        }else if(!Utils.emailRegex(text: email)){
            errorSubject.onNext(Localize.General.emailError)
        }else if(password.count <= 6){
            errorSubject.onNext(Localize.General.passwordError)
        }else if(password != confirmPassword){
            errorSubject.onNext(Localize.General.passwordNotEqualError)
        }else{
            registerUser(user: UserModel(email: email, password: password))
        }
        loadingsubject.onNext(false)
    }
    
    private func registerUser(user: UserModel) {
        loadingsubject.onNext(true)
        usecase.register(user: user) { [weak self] result in
            guard let self = self else{
                print("RVM* error in registerUser")
                return
            }
            self.loadingsubject.onNext(false)
            switch result {
            case .success():
                self.doneSubject.onNext(())
                NotificationCenter.default.post(name: .notificationForEmail, object: nil, userInfo: [Constants.emailNotificationDataKey: user.email])
            case .failure(let error):
                self.errorSubject.onNext(error.localizedDescription)
            }
        }
    }
    
    func navigateTo(to: DestinationScreens) {
        analyticEvent.registerClicked()
        analyticsService.report(event: analyticEvent)
        coordinator.dismiss()
    }
}
