//
//  ViewController.swift
//  groby
//
//  Created by 이재성 on 03/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menu: UIButton?
    @IBOutlet weak var menuView: UIView?
    @IBOutlet weak var viewForDimed: UIView?
    @IBOutlet weak var contentViewTrailing: NSLayoutConstraint?

    var isShownMenu: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        presentLoginView()
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionMenu))
        viewForDimed?.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func presentLoginView() {
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = loginStoryBoard.instantiateViewController(withIdentifier: "LoginRootViewController")
        present(loginViewController, animated: true, completion: nil)
    }

    @IBAction func fabButtonAction(_ sender: UIButton) {
        let makeTab1RootViewController = UIStoryboard(name: "MakeTab1", bundle: nil)
        let makeTab1ViewController = makeTab1RootViewController.instantiateViewController(withIdentifier: "MakeTab1RootViewController")
        present(makeTab1ViewController, animated: true, completion: nil)
    }

    @objc @IBAction func actionMenu(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            if !self.isShownMenu {
                self.viewForDimed?.isHidden = false
                self.contentViewTrailing?.constant = -(self.menuView!.bounds.width)
                self.isShownMenu = !self.isShownMenu
                self.viewForDimed?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.viewForDimed?.alpha = 0.4
            } else {
                self.viewForDimed?.isHidden = true
                self.contentViewTrailing?.constant = 0
                self.isShownMenu = !self.isShownMenu
                self.viewForDimed?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.viewForDimed?.alpha = 1.0
            }
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func actionShowAlarmView(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueShowAlarm", sender: nil)
    }

    @IBAction func actionSearch(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueSearch", sender: nil)
    }
}

// MARK: - Table View Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 201
        }
        return 104
    }
}

// MARK: - Table View Data Source

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DummyTableViewCell", for: indexPath) as? DummyTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }
}
