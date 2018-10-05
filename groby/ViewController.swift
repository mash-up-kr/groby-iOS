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
    @IBOutlet weak var tableView: UITableView? {
        didSet {
            tableView?.register(UINib(nibName: "MainHeaderView", bundle: nil), forCellReuseIdentifier: "MainHeaderView")
            tableView?.register(UINib(nibName: "CommonTableViewCell", bundle: nil), forCellReuseIdentifier: "CommonTableViewCell")
        }
    }

    var isShownMenu: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        presentLoginView()
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionMenu))
        viewForDimed?.addGestureRecognizer(tapGestureRecognizer)

        NotificationCenter.default.addObserver(self, selector: #selector(update), name: CommonTabViewController.addPostNotificationName, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestItemList()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: CommonTabViewController.addPostNotificationName, object: nil)
    }

    @objc private func update() {
        self.requestItemList()
    }

    private func requestItemList() {
        let path = "\(GrobyURL.base)\(GrobyURL.main.rawValue)\(MainItemListAPI.subURL)"
        let requestData = RequestData(path: path)
        MainItemListAPI(requestData).execute(onSuccess: { [weak self] mainItems in
            guard let self = self else {
                return
            }
            CommonDataManager.share.mainItems = mainItems.returnJson
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }) { error in
            assertionFailure("\(error)")
        }
    }

    private func presentLoginView() {
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = loginStoryBoard.instantiateViewController(withIdentifier: "LoginRootViewController")
        present(loginViewController, animated: true, completion: nil)
    }

    @IBAction private func fabButtonAction(_ sender: UIButton) {
        let makeTab1RootViewController = UIStoryboard(name: "MakeTab1", bundle: nil)
        let makeTab1ViewController = makeTab1RootViewController.instantiateViewController(withIdentifier: "MakeTab1RootViewController")
        present(makeTab1ViewController, animated: true, completion: nil)
    }

    @objc @IBAction private func actionMenu(_ sender: UIButton) {
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

    @IBAction private func actionShowAlarmView(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueShowAlarm", sender: nil)
    }

    @IBAction private func actionSearch(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueSearch", sender: nil)
    }
}

// MARK: - Table View Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("MainHeaderView", owner: self, options: nil)?.first as? MainHeaderView else {
            return nil
        }
        if section == 0 {
            headerView.configure(title: "현재 인기글")
        } else {
            headerView.configure(false, title: "최신글")
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 173
        }
        return 104
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 0 {
            return
        }

        guard let itemId = CommonDataManager.share.mainItems?.recentItemList[indexPath.row].itemId else {
            return
        }

        let path: String = "\(GrobyURL.base)\(GrobyURL.item.rawValue)\(itemId)"
        let requestData: RequestData = RequestData(path: path)
        ItemAPI(requestData).execute(onSuccess: { [weak self] itemJSON in            print("\(itemJSON.returnJson)")
            guard let `self` = self else {
                return
            }

            CommonDataManager.share.item = nil
            if let controller = UIStoryboard(name: "CommonTabView", bundle: nil).instantiateInitialViewController() as? CommonTabViewController {
                controller.item = itemJSON.returnJson

                self.navigationController?.pushViewController(controller, animated: true)
            }
        }) { error in
            print("ItemAPI: \(error)")
        }
    }
}

// MARK: - Table View Data Source

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainItems = CommonDataManager.share.mainItems else {
            return 0
        }

        if section == 0 {
            return 1
        } else {
            return mainItems.recentItemList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DummyTableViewCell", for: indexPath) as? DummyTableViewCell {
                cell.showItemViewClouser = { [weak self] item in
                    guard let self = self else {
                        return
                    }

                    if let controller = UIStoryboard(name: "CommonTabView", bundle: nil).instantiateInitialViewController() as? CommonTabViewController, let item = item {
                        controller.item = item
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommonTableViewCell", for: indexPath) as? CommonTableViewCell, let item = CommonDataManager.share.mainItems?.recentItemList[indexPath.row] {
                cell.configure(item)

                return cell
            }
        }
        return UITableViewCell()
    }
}
