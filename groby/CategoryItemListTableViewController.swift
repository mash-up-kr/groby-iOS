//
//  CategoryItemListTableViewController.swift
//  groby
//
//  Created by Daeyun Ethan on 24/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class CategoryItemListTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var categoryItems: ItemCardList? //[ItemList] = []
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
            }) { _ in
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

        let path: String = "\(GrobyURL.base)\(GrobyURL.item.rawValue)\(categoryItems?.itemList[indexPath.row].itemId)"
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
        if let count = categoryItems?.itemList.count {
            return count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "my_post_cell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }

        let categoryItem = categoryItems?.itemList[indexPath.row]

        let date = categoryItem?.dueDate.split(separator: " ")
        if let dateString = date?.first {
            cell.postDate.text = "\(dateString)"
        }
        cell.postTitle.text = categoryItem?.title

        cell.postLikeOrProgress.text = "좋아요 수"
        if let participantNum = categoryItem?.participantNum {
            cell.postLikeOrProgressCount.text = "\(participantNum)"
        }

        cell.postImage.image = #imageLiteral(resourceName: "person-1207641")

        return cell
    }
}
