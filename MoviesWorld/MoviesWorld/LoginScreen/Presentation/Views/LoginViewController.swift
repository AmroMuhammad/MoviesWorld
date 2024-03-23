//
//  LoginViewController.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    @IBOutlet private weak var loginLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var googleButton: UIImageView!
    @IBOutlet private weak var signUpButton: UILabel!
    @IBOutlet private weak var continueWithLabel: UILabel!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var dontHaveAccountLabel: UILabel!
    
    private var iconClick = true
    private var disposeBag:DisposeBag!
    var loginViewModel:LoginViewModelContract!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setPhoneNumber(_:)), name: .notificationForPhoneNumber, object: nil)
        
        disposeBag = DisposeBag()
        passwordTextField.disableAutoFill()
        passwordTextField.enablePasswordToggle()
        setGestures()
        listenOnObservables()
        setLocalization()
        loginViewModel.checkForLoggingState()
        
    }
    
    private func setGestures() {
        let googleGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectGoogle))
        googleButton.addGestureRecognizer(googleGesture)
        
        let signUpGesture = UITapGestureRecognizer(target: self, action: #selector(didClickSignUp))
        signUpButton.addGestureRecognizer(signUpGesture)
    }
    
    @objc private func didSelectGoogle() {
        print("google")
    }
    
    @objc private func didClickSignUp() {
        loginViewModel.navigateTo(to: .Register)
    }
    
    private func listenOnObservables(){
        loginViewModel.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else{
                print("LVC* error in errorObservable")
                return
            }
            self.showAlert(title: Localize.General.alertTitle, body: message, actions: [UIAlertAction(title: Localize.General.ok, style: UIAlertAction.Style.default, handler: nil)])
        }).disposed(by: disposeBag)
        
        loginViewModel.loadingObservable.subscribe(onNext: {[weak self] (boolValue) in
            guard let self = self else{
                print("LVC* error in errorObservable")
                return
            }
            switch boolValue{
            case true:
                self.showLoading()
            case false:
                self.hideLoading()
            }
        }).disposed(by: disposeBag)
        
        loginViewModel.signedInObservable.subscribe(onNext: {[weak self] (boolValue) in
            guard let self = self else{
                print("LVC* error in errorObservable")
                return
            }
            switch boolValue{
            case true:
                self.navigateToHomeScreen()
            case false:
                print("LVC* signedInObservable failed")
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func didLoginClicked(_ sender: Any) {
        loginViewModel.validateInputs(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    private func navigateToHomeScreen(){
        emailTextField.text = ""
        passwordTextField.text = ""
        loginViewModel.navigateTo(to: .Home)
    }
    
    private func setLocalization() {
        loginLabel.text = Localize.Login.loginTo
        emailTextField.placeholder = Localize.Login.email
        passwordTextField.placeholder = Localize.Login.password
        loginButton.setTitle(Localize.Login.login, for: .normal)
        continueWithLabel.text = Localize.Login.continueWith
        dontHaveAccountLabel.text = Localize.Login.dontHave
        signUpButton.text = Localize.Login.signup
        
    }
    
}

extension LoginViewController{
    @objc func setPhoneNumber(_ notification: Notification) {
        if let phoneNumber = notification.userInfo?[Constants.phoneNumberNotificationDataKey] as? String {
            emailTextField.text = phoneNumber
        }
    }
}
