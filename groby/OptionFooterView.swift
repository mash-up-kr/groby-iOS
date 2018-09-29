//
//  OptionFooterView.swift
//  groby
//
//  Created by Daeyun Ethan on 26/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class OptionFooterView: UITableViewHeaderFooterView {
    @IBOutlet weak var addOptionButton: UIButton!
    @IBOutlet weak var addOptionTextField: UITextField!

    var closure: ((String) -> Void)?

    @IBAction private func actionAddDetailOption(_ sender: UIButton) {
        if let text = addOptionTextField.text,
        !text.isEmpty {
            closure?(text)
            addOptionTextField.text = nil
        }
    }
}
