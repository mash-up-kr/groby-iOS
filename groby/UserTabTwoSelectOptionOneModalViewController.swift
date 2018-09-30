//
//  UserTabTwoSelectOptionOneModalViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 26/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class UserTabTwoSelectOptionOneModalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "SelectOptionHeaderView", bundle: nil), forCellReuseIdentifier: "SelectOptionHeaderView")
        }
    }

    var options: [(Bool, String)] = [(true, ""), (true, "")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func actionDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension UserTabTwoSelectOptionOneModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 84
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SelectOptionHeaderView") as? SelectOptionHeaderView else {
//            return nil
//        }
        guard let headerView = Bundle.main.loadNibNamed("SelectOptionHeaderView", owner: self, options: nil)?.first as? SelectOptionHeaderView else {
            return nil
        }
        headerView.button.tag = section
        headerView.button.addTarget(self, action: #selector(actionExpand(_ :)), for: .touchUpInside)

        let option = options[section]
        if !option.1.isEmpty {
            headerView.detailOptionLabel.text = options[section].1
        }

        if option.0 {
            headerView.button.setImage(#imageLiteral(resourceName: "drop down button.png"), for: .normal)
            headerView.detailOptionLabel.text = "사이즈 선택"
        } else {
            headerView.button.setImage(#imageLiteral(resourceName: "closedDropdownButton.png"), for: .normal)
        }

        return headerView
    }

    @objc func actionExpand(_ sender: UIButton) {
        let section = sender.tag
        options[section].0 = !options[section].0
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        options[indexPath.section].0 = !options[indexPath.section].0
        if let cell = tableView.cellForRow(at: indexPath) as? UserSelectOptionModalViewCell, let option = cell.optionDetailLabel.text {
            options[indexPath.section].1 = option
            tableView.reloadData()
        }
    }
}

extension UserTabTwoSelectOptionOneModalViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !options[section].0 {
            return 0
        }
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserSelectOptionModalViewCell", for: indexPath) as? UserSelectOptionModalViewCell else {
            return UITableViewCell()
        }
        cell.optionDetailLabel.text = "L"
        return cell
    }
}

class UserSelectOptionModalViewCell: UITableViewCell {

    @IBOutlet weak var optionDetailLabel: UILabel!

    func configure() {
    }
}
