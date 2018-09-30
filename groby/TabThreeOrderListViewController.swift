//
//  TabThreeOrderListViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 27/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class TabThreeOrderListViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.alpha = 0.0
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint! {
        didSet {
            bottomConstraint.constant = -600
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.5) {
            self.backgroundView.alpha = 1.0
            self.bottomConstraint.constant = 100
            self.view.layoutIfNeeded()
        }
    }

    @IBAction private func actionDelete(_ sender: UIButton) {

        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundView.alpha = 0.0
            self.bottomConstraint.constant = -600
            self.view.layoutIfNeeded()
        }) { _ in
            self.dismiss(animated: false, completion: nil)
        }
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
