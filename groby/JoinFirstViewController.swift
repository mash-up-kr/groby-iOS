//
//  JoinFirstViewController.swift
//  groby
//
//  Created by 이재성 on 04/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class JoinFirstViewController: UIViewController, AlertShowable {
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var checkNumTextField: LoginTextField!
    @IBOutlet weak var sendCheckNumButton: BlueButton!

    var isCheckEmail: Bool = false
    var checkedEmail: String?
    var authenticationNumber: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("Groby")
        setDelegate()
        sendCheckNumButton.activeButton(false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "JoinSecondSegue", let controller = segue.destination as? JoinSecondViewController {
            controller.checkedEmail = checkedEmail
        }

    }

    @IBAction func sendNumButtonAction(_ sender: UIButton) {
        if !isCheckEmail {
            checkEmail()
        } else {
            if let email = emailTextField.text, let checkedEmail = self.checkedEmail,
                let checkNum = checkNumTextField.text, let authenticationNumber = self.authenticationNumber,
                email == checkedEmail, checkNum == authenticationNumber {
                performSegue(withIdentifier: "JoinSecondSegue", sender: nil)
            } else {
                self.popUpAlert("Authentication number doesn't match.", message: "You should check authentication number or e-mail.")
            }
        }
    }

    func checkEmail() {
        if let email = emailTextField.text {
            let path: String = "\(GrobyURL.base)\(GrobyURL.user.rawValue)\(email)/check"
            let requestData = RequestData(path: path, method: .get)
            CommonAPIManager.execute(requestData, onSuccess: { [weak self] data in
                guard let `self` = self else {
                    return
                }
                print(data?["returnJson"] as? [String: Any])
                if let returnJson = data?["returnJson"] as? [String: Any], let authenticationNumber = returnJson["authenticationNumber"] as? String {
                    self.authenticationNumber = authenticationNumber
                    self.sendCheckNumButton.setTitle("다음", for: .normal)
                    self.isCheckEmail = true
                    self.checkedEmail = email
                    print("authenticationNumber: \(authenticationNumber)")
                } else {
                    self.popUpAlert("E-mail is already exist", message: "You should use another e-mail.")
                }
            }) { _ in
            }
        }
    }

    private func setDelegate() {
        checkNumTextField.loginTextFieldDelegate = self
        emailTextField.loginTextFieldDelegate = self
    }

    private func checkTextFieldEmpty() -> Bool {
        if emailTextField.text != "" {
            return true
        }
        return false
    }
}

extension JoinFirstViewController: LoginTextFieldDelegate {
    func textfieldChange() {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.1) { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                if strongSelf.checkTextFieldEmpty() {
                    self?.sendCheckNumButton.activeButton(true)
                } else {
                    self?.sendCheckNumButton.activeButton(false)
                }
            }
        }
    }
}
