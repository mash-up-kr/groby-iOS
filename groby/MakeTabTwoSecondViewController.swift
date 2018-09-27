//
//  MakeTabTwoSecondViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 25/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTabTwoSecondViewController: UIViewController {

    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addOptionButton: BlueButton!

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
    }

    @IBAction func actionNext(_ sender: UIButton) {
    }
}

extension MakeTabTwoSecondViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OptionHeaderView") as? OptionHeaderView else {
            return nil
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OptionFooterView") as? OptionFooterView else {
            return nil
        }
        return footerView
    }
}

extension MakeTabTwoSecondViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionViewCell", for: indexPath) as? OptionViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

class OptionViewCell: UITableViewCell {

    @IBOutlet weak var optionDetailLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
}
