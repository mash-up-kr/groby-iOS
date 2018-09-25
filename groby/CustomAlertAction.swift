//
//  CustomAlertAction.swift
//  groby
//
//  Created by Daeyun Ethan on 08/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

protocol AlertShowable {
    func popUpAlert(_ title: String?, message: String?)

    func alertAction(_ title: String?, message: String?, style: UIAlertController.Style, completion: @escaping ((UIAlertAction) -> Void))
}

extension AlertShowable where Self: UIViewController {
    func popUpAlert(_ title: String?, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancel)

        self.present(alertController, animated: false, completion: nil)
    }

    func alertAction(_ title: String?, message: String? = nil, style: UIAlertController.Style = .actionSheet, completion: @escaping ((UIAlertAction) -> Void) = { _ in }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: completion))
    }
}
