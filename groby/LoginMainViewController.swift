//
//  LoginMainViewController.swift
//  groby
//
//  Created by 이재성 on 03/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class LoginMainViewController: UIViewController {
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var loginButton: BlueButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setCustomTitle("Groby")
        setDelegate()
        loginButton.activeButton(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setDelegate() {
        passwordTextField.loginTextFieldDelegate = self
        emailTextField.loginTextFieldDelegate = self
    }
    
    private func checkTextFieldEmpty() -> Bool {
        if passwordTextField.text != "" && emailTextField.text != "" {
            return true
        }
        return false
    }
}

extension LoginMainViewController: LoginTextFieldDelegate {
    func textfieldChange() {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                if strongSelf.checkTextFieldEmpty() {
                    self?.loginButton.activeButton(true)
                } else {
                    self?.loginButton.activeButton(false)
                }
            }
        }
    }
}
