//
//  CustomAlertAction.swift
//  groby
//
//  Created by Daeyun Ethan on 08/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

protocol AlertShowable {
    func popUpAlert(_ title: String, message: String)
}

extension AlertShowable where Self: UIViewController {
    func popUpAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancel)

        self.present(alertController, animated: false, completion: nil)
    }
}
