//
//  MakeTab1ThirdTableTableViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1ThirdTableTableViewController: UITableViewController, AlertShowable {

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
        var defaultDate: Date?
        if let dateString = endDateButton.titleLabel?.text,
            let date = dateFormatter.date(from: dateString) {
            defaultDate = date
        }

        alertDate("종료 날짜 설정", defaultDate: defaultDate) { [weak self] date in
            guard let `self` = self else {
                return
            }
            self.endDateButton.setTitle("\(self.dateFormatter.string(from: date))", for: .normal)
        }
    }

    @IBAction private func nextButtonAction(_ sender: UIButton) {
        guard let makeTab1FourthViewController = storyboard?.instantiateViewController(withIdentifier: "MakeTab1FourthViewController") as? MakeTab1FourthViewController else {
            return
        }

        CommonDataManager.share.itemForPost?.itemAmountLimit = minimumCountTextField.text
        CommonDataManager.share.itemForPost?.tabOne?.endDate = endDateButton.titleLabel?.text
        CommonDataManager.share.itemForPost?.tabOne?.location = locationTextField.text
        navigationController?.pushViewController(makeTab1FourthViewController, animated: true)
    }
}
