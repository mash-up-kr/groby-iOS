//
//  TabThreeOrderListViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 27/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class TabThreeOrderListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func ActionDelete(_ sender: UIButton) {
    }
}

extension TabThreeOrderListViewController: UITableViewDelegate {

}

extension TabThreeOrderListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListViewCell", for: indexPath) as? OrderListViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

class OrderListViewCell: UITableViewCell {
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var countLabel: UIView!

    func configure() {
    }
}
