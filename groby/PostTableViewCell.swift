//
//  MyPostTableViewCell.swift
//  groby
//
//  Created by byungtak on 2018. 8. 3..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postLikeOrProgress: UILabel!
    @IBOutlet weak var postLikeOrProgressCount: UILabel!
}
