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
    func alertDate(_ title: String, defaultDate: Date?, completion: @escaping (Date) -> Void)
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

    func alertDate(_ title: String, defaultDate: Date? = nil, completion: @escaping (Date) -> Void = { _ in }) {
        let datePicker = UIDatePicker(frame: CGRect(x: 20.0, y: 50.0, width: UIScreen.main.bounds.width - 50.0, height: 100))
        datePicker.minimumDate = Date()

        if let date = defaultDate {
            datePicker.date = date
        }

        let alertViewController = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        alertViewController.view.addSubview(datePicker)
        alertViewController.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            completion(datePicker.date)
        }))
        alertViewController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alertViewController.view.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        present(alertViewController, animated: true, completion: nil)
    }
}
