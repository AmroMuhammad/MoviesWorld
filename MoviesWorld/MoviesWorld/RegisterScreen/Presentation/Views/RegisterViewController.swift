//
//  RegisterViewController.swift
//  MoviesWorld
//
//  Created by Amr Muhammad on 23/03/2024.
//  Copyright © 2021 Amr Muhammad. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RegisterViewController: BaseViewController {
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var registerViewModel:RegisterViewModelContract!
    private var disposeBag:DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disposeBag = DisposeBag()
        
        passwordTextField.disableAutoFill()
        confirmPasswordTextField.disableAutoFill()
        passwordTextField.enablePasswordToggle()
        confirmPasswordTextField.enablePasswordToggle()
        setLocalization()
        listenOnObservables()
    }
    
    private func listenOnObservables(){
        registerViewModel.errorObservable.subscribe(onNext: {[weak self] (message) in
            guard let self = self else{
                print("RVC* error in errorObservable")
                return
            }
            self.showAlert(title: Localize.General.alertTitle, body: message, actions: [UIAlertAction(title: Localize.General.ok, style: UIAlertAction.Style.default, handler: nil)])
            
            }).disposed(by: disposeBag)
        
        registerViewModel.loadingObservable.subscribe(onNext: {[weak self] (result) in
            guard let self = self else{
                print("RVC* error in loadingObservable")
                return
            }
            switch result{
            case true:
                self.showLoading()
            case false:
                self.hideLoading()
            }
            }).disposed(by: disposeBag)
        
//        registerViewModel.doneObservable.subscribe(onNext: {[weak self] (user) in
//            guard let self = self else{
//                print("RVC* error in doneObservable")
//                return
//            }
//            self.registerViewModel.navigateTo(to: .Login)
//            }).disposed(by: disposeBag)
    }
    
    private func setLocalization() {
        registerLabel.text = Localize.Register.register
        emailTextField.placeholder = Localize.General.email
        passwordTextField.placeholder = Localize.General.password
        confirmPasswordTextField.placeholder = Localize.Register.confirmPassword
        signupButton.setTitle(Localize.General.signup, for: .normal)
        
    }
  
    @IBAction func didSubmitClicked(_ sender: Any) {
        registerViewModel.validateInputData(email: emailTextField.text!, password: passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
    }
}
