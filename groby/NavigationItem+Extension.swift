//
//  NavigationItem+Extension.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

extension UINavigationItem {
    func setCustomTitle(_ text: String) {
        let titleLabel = UILabel()
        let title = NSMutableAttributedString(string: text, attributes:[
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.medium)])
        titleLabel.attributedText = title
        titleLabel.sizeToFit()
        titleView = titleLabel
    }
}
