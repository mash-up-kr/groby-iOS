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
            tableView.register(UINib.init(nibName: "SelectOptionHeaderView", bundle: nil), forCellReuseIdentifier: "SelectOptionHeaderView")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension UserTabTwoSelectOptionOneModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SelectOptionHeaderView") as? SelectOptionHeaderView else {
            return nil
        }
        return headerView
    }
}

extension UserTabTwoSelectOptionOneModalViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserSelectOptionModalViewCell", for: indexPath) as? UserSelectOptionModalViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

class UserSelectOptionModalViewCell: UITableViewCell {
    
    @IBOutlet weak var optionDetailLabel: UILabel!
    
    func configure() {
    }
}
