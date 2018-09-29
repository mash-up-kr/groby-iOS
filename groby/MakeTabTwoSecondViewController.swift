//
//  MakeTabTwoSecondViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 25/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTabTwoSecondViewController: UIViewController, AlertShowable {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addOptionButton: BlueButton!

    var optionCount: Int = 0 {
        didSet {
            detailOptionCount.append(([], 0))
        }
    }
    var detailOptionCount: [([String], Int)] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
             tableView.register(UINib(nibName: "OptionHeaderView", bundle: nil), forCellReuseIdentifier: "OptionHeaderView")
            tableView.register(UINib(nibName: "OptionFooterView", bundle: nil), forCellReuseIdentifier: "OptionFooterView")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func actionAddOption(_ sender: UIButton) {
        optionCount += 1
    }

    @IBAction private func actionNext(_ sender: UIButton) {
    }
}

extension MakeTabTwoSecondViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OptionHeaderView") as? OptionHeaderView else {
//            return nil
//        }
        guard let headerView = Bundle.main.loadNibNamed("OptionHeaderView", owner: self, options: nil)?.first as? OptionHeaderView else {
            return nil
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OptionFooterView") as? OptionFooterView else {
//            return nil
//        }
        guard let footerView = Bundle.main.loadNibNamed("OptionFooterView", owner: self, options: nil)?.first as? OptionFooterView else {
            return nil
        }

        footerView.closure = { [weak self] detailOption in
            guard let self = self else {
                return
            }

            if self.detailOptionCount[section].0.contains(detailOption) {
                self.popUpAlert("세부 옵션이 중복 되었습니다.")
                return
            }

            self.detailOptionCount[section].0.append(detailOption)
            self.detailOptionCount[section].1 += 1
        }

        return footerView
    }
}

extension MakeTabTwoSecondViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return optionCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailOptionCount[section].1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionViewCell", for: indexPath) as? OptionViewCell else {
            return UITableViewCell()
        }

        cell.configure(detailOptionCount[indexPath.section].0[indexPath.row])
        cell.deleteClosure = { [weak self] in
            guard let self = self else {
                return
            }
            self.detailOptionCount[indexPath.section].1 -= 1

            self.detailOptionCount[indexPath.section].0.remove(at: indexPath.row)
            self.tableView.reloadData()
        }

        return cell
    }
}

class OptionViewCell: UITableViewCell {

    @IBOutlet weak var optionDetailLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    var deleteClosure: (() -> Void)?

    func configure(_ title: String) {
        optionDetailLabel.text = title
    }

    @IBAction private func actionDelete() {
        deleteClosure?()
    }
}
