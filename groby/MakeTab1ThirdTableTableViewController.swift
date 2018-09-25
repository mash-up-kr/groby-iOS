//
//  MakeTab1ThirdTableTableViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1ThirdTableTableViewController: UITableViewController {

    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var minimumCountTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!

    let dateFormatter: DateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("세부 설정")

        dateFormatter.dateFormat = "yyyy-MM-dd"
        endDateButton.setTitle(dateFormatter.string(from: Date()), for: .normal)
    }

    @IBAction private func setDate(_ sender: UIButton) {
        let datePicker = UIDatePicker(frame: CGRect(x: 20.0, y: 50.0, width: tableView.bounds.width - 50.0, height: 100))

        if let dateString = endDateButton.titleLabel?.text,
            let date = dateFormatter.date(from: dateString) {
            datePicker.date = date
        }

        let alertViewController = UIAlertController(title: "종료 날짜 설정", message: "", preferredStyle: .actionSheet)
        alertViewController.view.addSubview(datePicker)
        alertViewController.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            guard let `self` = self else {
                return
            }
            self.endDateButton.setTitle("\(self.dateFormatter.string(from: datePicker.date))", for: .normal)
        }))
        alertViewController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alertViewController.view.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        present(alertViewController, animated: true, completion: nil)
    }

    @IBAction private func nextButtonAction(_ sender: UIButton) {
        guard let makeTab1FourthViewController = storyboard?.instantiateViewController(withIdentifier: "MakeTab1FourthViewController") as? MakeTab1FourthViewController else {
            return
        }

//        CommonDataManager.share.item?.itemAmountLimit = minimumCountTextField.text
        CommonDataManager.share.item?.tabOne?.endDate = endDateButton.titleLabel?.text
        CommonDataManager.share.item?.tabOne?.location = locationTextField.text
        navigationController?.pushViewController(makeTab1FourthViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
