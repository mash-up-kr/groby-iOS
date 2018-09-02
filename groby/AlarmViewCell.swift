//
//  AlarmViewCell.swift
//  groby
//
//  Created by Daeyun Ethan Kim on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class AlarmViewCell: UITableViewCell {

    @IBOutlet weak var stepLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setProperties()
    }

    private func setProperties() {
        stepLabel.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        stepLabel.layer.borderWidth = 1.0
        stepLabel.layer.cornerRadius = 13.0
    }
}
