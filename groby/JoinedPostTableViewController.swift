//
//  JoinedPostViewController.swift
//  groby
//
//  Created by byungtak on 2018. 8. 18..
//  Copyright © 2018년 mashup. All rights reserved.
//

import UIKit

class JoinedPostTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var categoryItems: [CategoryItem] = []
    var category: Category?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let category = category {
            navigationItem.setCustomTitle(category.category)
            let path: String = "\(GrobyURL.base)\(GrobyURL.main.rawValue)\(GrobyURL.category.rawValue)\(category.categotyId)"
            let requestData = RequestData(path: path)
            CategoryItemAPI(requestData).execute(onSuccess: { [weak self] categoryItems in
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

}

extension JoinedPostTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "my_post_cell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }

        let categoryItem = categoryItems[indexPath.row]

        cell.postTitle.text = categoryItem.title
        cell.postDate.text = "\(categoryItem.dueDate)"

        if true {
            cell.postLikeOrProgress.text = "좋아요 수"
            if let participantNum = categoryItem.participantNum {
                cell.postLikeOrProgressCount.text = "\(participantNum)"
            }
        } else {
            cell.postLikeOrProgress.text = "진행률"
            if let progress = categoryItem.progress {
                cell.postLikeOrProgressCount.text = "\(progress)"
            }
        }
        return cell
    }
}
