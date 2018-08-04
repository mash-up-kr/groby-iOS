//
//  JoinFirstViewController.swift
//  groby
//
//  Created by 이재성 on 04/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class JoinFirstViewController: UIViewController {
    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var checkNumTextField: LoginTextField!
    @IBOutlet weak var sendCheckNumButton: BlueButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        sendCheckNumButton.activeButton(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendNumButtonAction(_ sender: UIButton) {
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

