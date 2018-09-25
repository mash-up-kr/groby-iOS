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

extension ItemListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.items, !items.isEmpty else {
            return 0
        }
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "my_post_cell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        //
        //        let categoryItem = categoryItems[indexPath.row]
        //
        //        let date = categoryItem.dueDate.split(separator: " ")
        //        if let dateString = date.first {
        //            cell.postDate.text = "\(dateString)"
        //        }
        //        cell.postTitle.text = categoryItem.title
        //
        //        if true {
        //            cell.postLikeOrProgress.text = "좋아요 수"
        //            if let participantNum = categoryItem.participantNum {
        //                cell.postLikeOrProgressCount.text = "\(participantNum)"
        //            }
        //        } else {
        //            cell.postLikeOrProgress.text = "진행률"
        //            if let progress = categoryItem.progress {
        //                cell.postLikeOrProgressCount.text = "\(progress)"
        //            }
        //        }
        return cell
    }
}
