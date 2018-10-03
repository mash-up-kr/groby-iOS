//
//  MyPostTableViewCell.swift
//  groby
//
//  Created by byungtak on 2018. 8. 3..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeOrProgressLabel: UILabel!
    @IBOutlet weak var likeOrProgressCountLabel: UILabel!

    func configure(_ data: ItemList) {
        titleLabel.text = data.title
        dateLabel.text = data.dueDate
        likeOrProgressLabel.text = "좋아요 수"
        likeOrProgressCountLabel.text = data.likeNum
    }
}
