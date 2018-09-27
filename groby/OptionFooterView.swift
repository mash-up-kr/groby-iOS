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

    var detailOptionCount: Int = 0
    var closure: ((String, Int) -> Void)?

    @IBAction func actionAddDetailOption(_ sender: UIButton) {
        if let text = addOptionTextField.text,
        !text.isEmpty {
            detailOptionCount += 1
            closure?(text, detailOptionCount)
        }
    }
}
