//
//  JoinSecondViewController.swift
//  groby
//
//  Created by 이재성 on 04/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class JoinSecondViewController: UIViewController {
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var nickNameTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var checkPasswordTextField: LoginTextField!
    @IBOutlet weak var signUpButton: BlueButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        signUpButton.activeButton(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setDelegate() {
        nickNameTextField.loginTextFieldDelegate = self
        emailTextField.loginTextFieldDelegate = self
        passwordTextField.loginTextFieldDelegate = self
        checkPasswordTextField.loginTextFieldDelegate = self
    }
    
    private func checkTextFieldEmpty() -> Bool {
        if nickNameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" && checkPasswordTextField.text != "" {
            return true
        }
        return false
    }
    
    private func checkPasswordSame() -> Bool {
        if passwordTextField.text == checkPasswordTextField.text {
            return true
        }
        return false
    }
}

extension JoinSecondViewController: LoginTextFieldDelegate {
    func textfieldChange() {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                if strongSelf.checkTextFieldEmpty() && strongSelf.checkPasswordSame() {
                    self?.signUpButton.activeButton(true)
                } else {
                    self?.signUpButton.activeButton(false)
                }
            }
        }
    }
}


