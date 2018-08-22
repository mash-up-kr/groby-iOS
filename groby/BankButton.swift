//
//  BankButton.swift
//  groby
//
//  Created by YunHee Lee on 2018. 8. 22..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class BankButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()

        setTitleColor(.black, for: .normal)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        makeBorder()
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
