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
//    private var doneSubject = PublishSubject<User>()
    private let analyticsService: AnalyticsServiceContract
    private var analyticEvent = RegisterScreenAnalyticEventImplementation()

    var errorObservable: Observable<(String)>
    var loadingObservable: Observable<Bool>
//    var doneObservable: Observable<User>
    var coordinator: CoordinatorProtocol
    let usecase: RegisterUsecaseContract
    
    init(coordinator: CoordinatorProtocol, usecase: RegisterUsecaseContract, analyticsService: AnalyticsServiceContract) {
        self.coordinator = coordinator
        self.usecase = usecase
        self.analyticsService = analyticsService
        errorObservable = errorSubject.asObservable()
        loadingObservable = loadingsubject.asObservable()
//        doneObservable = doneSubject.asObservable()
    }
    
    func validateInputData(email: String, password: String, confirmPassword: String){
        loadingsubject.onNext(true)
        if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
            errorSubject.onNext(Localize.General.emptyFieldsError)
        }else if(!Utils.emailRegex(text: email)){
            errorSubject.onNext(Localize.General.emailError)
        }else if(password.count <= 5){
            errorSubject.onNext(Localize.General.passwordError)
        }else if(password != confirmPassword){
            errorSubject.onNext(Localize.General.passwordNotEqualError)
        }else{
//            saveUser(user: User(phoneNumber: phoneNumber, password: password))
        }
        loadingsubject.onNext(false)
    }
    
//    private func saveUser(user: User) {
//        loadingsubject.onNext(true)
//        usecase.fetchUser(byPhoneNumber: user.phoneNumber) {[weak self] (result) in
//            guard let self = self else{
//                print("RVM* error in saveUser")
//                return
//            }
//            switch result{
//            case .success(_):
//                self.loadingsubject.onNext(false)
//                self.errorSubject.onNext(Constants.userFoundError)
//            case .failure(_):
//                self.usecase.save(user: user) { (result) in
//                    switch result{
//                    case .success(_):
//                        self.loadingsubject.onNext(false)
//                        self.doneSubject.onNext(user)
//                        NotificationCenter.default.post(name: .notificationForPhoneNumber, object: nil, userInfo: [Constants.phoneNumberNotificationDataKey: user.phoneNumber])
//                    case .failure(_):
//                        self.loadingsubject.onNext(false)
//                        self.errorSubject.onNext(Constants.genericError)
//                    }
//                }
//
//            }
//        }
//    }
    
    func navigateTo(to: DestinationScreens) {
        analyticEvent.registerClicked()
        analyticsService.report(event: analyticEvent)
        coordinator.dismiss()
    }
}
