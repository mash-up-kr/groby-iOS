//
//  myPageTableViewController.swift
//  groby
//
//  Created by YunHee Lee on 2018. 8. 18..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class MyPageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("개인정보 관리")
        let newBackButton = UIBarButtonItem(title: " ",
                                            style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
