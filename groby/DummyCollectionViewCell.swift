//
//  DummyCollectionViewCell.swift
//  groby
//
//  Created by Daeyun Ethan Kim on 11/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class DummyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView?

    func configure(_ title: String, image: UIImage? = nil) {
        titleLabel.text = title
    }
}
