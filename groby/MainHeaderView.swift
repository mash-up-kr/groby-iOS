//
//  MainHeaderView.swift
//  groby
//
//  Created by Daeyun Ethan on 03/10/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MainHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var moreButton: UIButton!

    func configure(_ hidden: Bool = true, title: String) {
        moreButton.isHidden = hidden
        titleLable.text = title
    }
}
