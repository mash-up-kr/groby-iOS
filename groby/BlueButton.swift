//
//  BlueButton.swift
//  groby
//
//  Created by 이재성 on 03/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class BlueButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()

        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        makeBorder()
    }

    private func makeBorder() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }

    func activeButton(_ bool: Bool) {
        backgroundColor = bool ? #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1) : #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        setTitleColor(.white, for: .normal)
    }
}
