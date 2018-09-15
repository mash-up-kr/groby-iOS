//
//  myPageTableViewController.swift
//  groby
//
//  Created by YunHee Lee on 2018. 8. 18..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class MyPageTableViewController: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextFieled: UITextField!
    @IBOutlet weak var bankHolderTextFieled: UITextField!
    @IBOutlet weak var bankNameTextFieled: UITextField!
    @IBOutlet weak var bankAccountTextFieled: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("개인정보 관리")
        let newBackButton = UIBarButtonItem(title: " ",
                                            style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
        setUserInfo()
    }

    func setUserInfo() {
        emailTextField.text = CommonDataManager.share.userInfo?.userEmail
        nicknameTextField.text = CommonDataManager.share.userInfo?.userName
        phoneNumberTextFieled.text = CommonDataManager.share.userInfo?.phoneNumber
        bankHolderTextFieled.text = CommonDataManager.share.userInfo?.accountHolder
        bankNameTextFieled.text = CommonDataManager.share.userInfo?.accountBank
        bankAccountTextFieled.text = CommonDataManager.share.userInfo?.accountNum
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
