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

    @IBAction private func loginButtonAction(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            let path: String = "\(GrobyURL.base)\(GrobyURL.user.rawValue)\(UserLoginAPI.subUrl)"
            let params: [String: Any?] = ["userEmail": email,
                                            "userPw": password]
            let requestData = RequestData(path: path, method: .post, params: params)
            let login = UserLoginAPI(requestData)
            login.execute(onSuccess: { [weak self] userJson in
                guard let `self` = self else {
                    return
                }
                CommonDataManager.share.userInfo = userJson.returnJson

                self.dismiss(animated: true, completion: nil)
            }) { [weak self]error in
                guard let `self` = self else {
                    return
                }
                let alertController = UIAlertController(title: "Login failed", message: "You should check your e-mail or password.", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(cancel)

                self.present(alertController, animated: false, completion: nil)
                print("Login Error: \(error)")
            }
        }
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
