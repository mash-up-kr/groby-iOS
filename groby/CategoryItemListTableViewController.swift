//
//  CategoryItemListTableViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 24/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class CategoryItemListTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CommonTableViewCell", bundle: nil), forCellReuseIdentifier: "CommonTableViewCell")
        }
    }

    private var categoryItems: [ItemList] = []
    var category: Category?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let category = category {
            navigationItem.setCustomTitle(category.category)
            let path: String = "\(GrobyURL.base)\(GrobyURL.main.rawValue)\(GrobyURL.category.rawValue)\(category.categoryId)"
            let requestData = RequestData(path: path)
            ItemListAPI(requestData).execute(onSuccess: { [weak self] categoryItems in
                guard let `self` = self else {
                    return
                }
                print(categoryItems)
                self.categoryItems = categoryItems.returnJson
                self.tableView.reloadData()
            }) { error in
                print("ItemListAPI: \(error)")
            }
        } else {
            navigationItem.setCustomTitle("참여한 글")
        }

        let newBackButton = UIBarButtonItem(title: " ", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
    }

    func requestItem() {

    }
}

extension CategoryItemListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let path: String = "\(GrobyURL.base)\(GrobyURL.item.rawValue)\(categoryItems[indexPath.row].itemId)"
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

extension CategoryItemListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CommonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommonTableViewCell", for: indexPath) as? CommonTableViewCell else {
            return UITableViewCell()
        }

        let categoryItem = categoryItems[indexPath.row]

        let date = categoryItem.dueDate?.split(separator: " ")
        if let dateString = date?.first {
            cell.dateLabel.text = "\(dateString)"
        }
        cell.titleLabel.text = categoryItem.title

        cell.likeOrProgressLabel.text = "좋아요 수"
        if let participantNum = categoryItem.participantNum {
            cell.likeOrProgressCountLabel.text = "\(participantNum)"
        }

        cell.itemImageView.image = #imageLiteral(resourceName: "person-1207641")

        return cell
    }
}
