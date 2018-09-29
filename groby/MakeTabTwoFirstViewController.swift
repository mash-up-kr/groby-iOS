//
//  MakeTabTwoFirstViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 25/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTabTwoFirstViewController: UITableViewController, AlertShowable {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noticeTextField: UITextView!
    @IBOutlet weak var fromDueDateButton: UIButton!
    @IBOutlet weak var toDueDateButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var bankNameButton: UIButton!
    @IBOutlet weak var bankAccountNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    let dateFormatter: DateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("폼 내용 작성")

        dateFormatter.dateFormat = "yyyy-MM-dd"
        fromDueDateButton.setTitle(dateFormatter.string(from: Date()), for: .normal)
        toDueDateButton.setTitle(dateFormatter.string(from: Date()), for: .normal)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    @IBAction private func actionNext(_ sender: UIButton) {
        performSegue(withIdentifier: "showNextSegue", sender: nil)
    }

    @IBAction private func actionSetFromDate(_ sender: UIButton) {
        var defaultDate: Date?
        if let dateString = fromDueDateButton.titleLabel?.text,
            let date = dateFormatter.date(from: dateString) {
            defaultDate = date
        }

        alertDate("시작 날짜 설정", defaultDate: defaultDate) { [weak self] date in
            guard let `self` = self else {
                return
            }
            self.fromDueDateButton.setTitle("\(self.dateFormatter.string(from: date))", for: .normal)

            if let toDateString = self.toDueDateButton.titleLabel?.text,
                let toDate = self.dateFormatter.date(from: toDateString) {
                let timeInterval = toDate.timeIntervalSince(date)
                if timeInterval < 0 {
                    self.toDueDateButton.setTitle("\(self.dateFormatter.string(from: date))", for: .normal)
                }
            }
        }
    }

    @IBAction private func actionSetToDate(_ sender: UIButton) {
        var defaultDate: Date?
        if let dateString = toDueDateButton.titleLabel?.text,
            let date = dateFormatter.date(from: dateString) {
            defaultDate = date
        }

        alertDate("종료 날짜 설정", defaultDate: defaultDate) { [weak self] date in
            guard let `self` = self else {
                return
            }
            self.toDueDateButton.setTitle("\(self.dateFormatter.string(from: date))", for: .normal)

            if let fromDateString = self.fromDueDateButton.titleLabel?.text,
                let fromDate = self.dateFormatter.date(from: fromDateString) {
                let timeInterval = date.timeIntervalSince(fromDate)
                if timeInterval < 0 {
                    self.fromDueDateButton.setTitle("\(self.dateFormatter.string(from: date))", for: .normal)
                }
            }
        }
    }

    @IBAction private func actionSetBank(_ sender: UIButton) {
        performSegue(withIdentifier: "presentBankListSegue", sender: nil)
    }
}
