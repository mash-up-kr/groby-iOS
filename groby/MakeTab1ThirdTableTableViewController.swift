//
//  MakeTab1ThirdTableTableViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1ThirdTableTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("세부 설정")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func nextButtonAction(_ sender: UIButton) {
        guard let makeTab1FourthViewController = storyboard?.instantiateViewController(withIdentifier: "MakeTab1FourthViewController") as? MakeTab1FourthViewController else { return }
        navigationController?.pushViewController(makeTab1FourthViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
