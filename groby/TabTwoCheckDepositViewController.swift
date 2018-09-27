//
//  TabTwoCheckDepositViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 26/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class TabTwoCheckDepositViewController: UIViewController {

    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "DepositConfirmHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DepositConfirmHeaderFooterView")
            tableView.register(UINib(nibName: "DepositConfirmListHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DepositConfirmListHeaderView")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func actionNext(_ sender: UIButton) {
    }
}

extension TabTwoCheckDepositViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DepositConfirmHeaderFooterView") as? DepositConfirmHeaderFooterView {
                return headerView
            }
        } else {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DepositConfirmListHeaderView")as? DepositConfirmListHeaderView {
                return headerView
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != 0 {
            if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DepositConfirmHeaderFooterView") as? DepositConfirmHeaderFooterView {
                return footerView
            }
        }
        return nil
    }
}

extension TabTwoCheckDepositViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmDepositViewCell", for: indexPath) as? ConfirmDepositViewCell {
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmDepositListExpandViewCell", for: indexPath) as? ConfirmDepositListExpandViewCell {
                return cell
            }
        }
        return UITableViewCell()
    }
}

class ConfirmDepositViewCell: UITableViewCell {
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var bankAccountLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var suspandButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!

    @IBAction func actionSuspand(_ sender: UIButton) {
    }

    @IBAction func actionConfirm(_ sender: UIButton) {
    }
}

class ConfirmDepositListViewCell: UITableViewCell {

    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}
class ConfirmDepositListExpandViewCell: UITableViewCell {

    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bankAccountLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
}
