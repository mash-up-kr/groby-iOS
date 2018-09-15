//
//  JoinSecondViewController.swift
//  groby
//
//  Created by 이재성 on 04/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class JoinSecondViewController: UIViewController, AlertShowable {
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var nickNameTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var checkPasswordTextField: LoginTextField!
    @IBOutlet weak var signUpButton: BlueButton!

    var checkedEmail: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("Groby")
        setDelegate()
        signUpButton.activeButton(false)
        emailTextField.text = checkedEmail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func signUpButtonAction(_ sender: UIButton) {
        if let email = emailTextField.text, let name = nickNameTextField.text, let password = passwordTextField.text {
            let path: String = "\(GrobyURL.base)\(GrobyURL.user.rawValue)"
            let params: [String: Any?] = ["userEmail": email,
                                          "userName": name,
                                          "userPw": password,
                                          "userToken": "string"]

            let requestData = RequestData(path: path, method: .post, params: params)
            CommonAPIManager.execute(requestData, onSuccess: { [weak self] data in
                guard let `self` = self else {
                    return
                }

                if let status = data?["status"] as? String, status == "OK" {
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    self.popUpAlert("You couldn't join", message: "You should check password or token.")
                }
            }) { _ in
            }
        }
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
