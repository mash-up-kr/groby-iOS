//
//  UserTabTwoSelectOptionTwoViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 26/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class UserTabTwoSelectOptionTwoViewController: UIViewController {

    @IBOutlet weak var postButtonView: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "SelectOptionTwoFooterView", bundle: nil), forCellReuseIdentifier: "SelectOptionTwoFooterView")
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankAccountNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UserTabTwoSelectOptionTwoViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = tableView.contentSize.height
        if scrollView.contentOffset.y >= contentHeight {
            postButtonView.isHidden = false
        } else {
            postButtonView.isHidden = true
        }
        
        print("\(contentHeight) \(scrollView.contentOffset.y)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentHeight = tableView.contentSize.height
        if scrollView.contentOffset.y >= contentHeight {
            postButtonView.isHidden = false
        } else {
            postButtonView.isHidden = true
        }
    }
}

extension UserTabTwoSelectOptionTwoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SelectOptionTwoFooterView") as? SelectOptionTwoFooterView else {
            return nil
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension UserTabTwoSelectOptionTwoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class UserSelectOptionTwoNoticeViewCell: UITableViewCell {
    
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var bankAccountLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var remainTextLabel: UILabel!
    
    func configure() {
        
    }
}

class UserSelectOptionTwoOptionViewCell: UITableViewCell {
    
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    func configure() {
        
    }
}
