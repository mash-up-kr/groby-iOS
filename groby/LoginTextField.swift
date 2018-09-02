//
//  LoginTextField.swift
//  groby
//
//  Created by 이재성 on 03/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

protocol LoginTextFieldDelegate: class {
    func textfieldChange()
}

class LoginTextField: UITextField {
    weak var loginTextFieldDelegate: LoginTextFieldDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self

        makePadding()
        makeBorder()
    }

    private func makePadding() {
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: 25, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }

    private func makeBorder() {
        layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1).cgColor
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 2
        clipsToBounds = true
    }

    private func activeTextField(_ bool: Bool) {
        layer.borderColor = bool ? #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1).cgColor : #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1).cgColor
    }
}

extension LoginTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        loginTextFieldDelegate?.textfieldChange()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField(false)
    }
}
