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

    var expanded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction private func actionNext(_ sender: UIButton) {
    }
}

extension TabTwoCheckDepositViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 11
        } else {
            return 40
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
//            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DepositConfirmHeaderFooterView") as? DepositConfirmHeaderFooterView {
//                return headerView
//            }
            if let headerView = Bundle.main.loadNibNamed("DepositConfirmHeaderFooterView", owner: self, options: nil)?.first as? DepositConfirmHeaderFooterView {
                return headerView
            }
        } else {
//            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DepositConfirmListHeaderView")as? DepositConfirmListHeaderView {
//                return headerView
//            }
            if let headerView = Bundle.main.loadNibNamed("DepositConfirmListHeaderView", owner: self, options: nil)?.first as? DepositConfirmListHeaderView {
                var image: UIImage
                if expanded {
                    image = #imageLiteral(resourceName: "dropdown button.png")
                } else {
                    image = #imageLiteral(resourceName: "expand button.png")
                }
                headerView.buttonImage.image = image
                headerView.expandButton.addTarget(self, action: #selector(actionExpand), for: .touchUpInside)
                return headerView
            }
        }
        return nil
    }

    @objc func actionExpand() {
        expanded = !expanded
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 11
        }
        return CGFloat.leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
//            if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DepositConfirmHeaderFooterView") as? DepositConfirmHeaderFooterView {
//                return footerView
//            }
            if let footerView = Bundle.main.loadNibNamed("DepositConfirmHeaderFooterView", owner: self, options: nil)?.first as? DepositConfirmHeaderFooterView {
                return footerView
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 151
        } else {
            return 104
        }
    }
}

extension TabTwoCheckDepositViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if expanded {
                return 2
            } else {
                return 0
            }
        }
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

    @IBAction private func actionSuspand(_ sender: UIButton) {
    }

    @IBAction private func actionConfirm(_ sender: UIButton) {
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
