//
//  DistributionViewController.swift
//  groby
//
//  Created by byungtak on 04/10/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class DistributionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension DistributionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
