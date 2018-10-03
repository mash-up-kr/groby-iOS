//
//  ItemListTableViewController.swift
//  groby
//
//  Created by byungtak on 2018. 8. 18..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class ItemListTableViewController: UIViewController {

    var items: [ItemList]?
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let newBackButton = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
    }

}

extension ItemListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let itemId = items?[indexPath.row].itemId else {
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

extension ItemListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.items, !items.isEmpty else {
            return 0
        }
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CommonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommonTableViewCell", for: indexPath) as? CommonTableViewCell, let item = items?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(item)
        return cell
    }
}
