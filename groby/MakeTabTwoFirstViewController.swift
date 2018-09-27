//
//  MakeTabTwoFirstViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 25/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTabTwoFirstViewController: UITableViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noticeTextField: UITextView!
    @IBOutlet weak var fromDueDateButton: UIButton!
    @IBOutlet weak var toDueDateButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var bankNameButton: UIButton!
    @IBOutlet weak var bankAccountNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionNext(_ sender: UIButton) {
    }
}
