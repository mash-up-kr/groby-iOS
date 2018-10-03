//
//  MenuViewController.swift
//  groby
//
//  Created by Daeyun Ethan Kim on 11/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController, AlertShowable {

    @IBOutlet weak var wroteButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var userNicknameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("Groby")
        setProperties()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
        userNicknameLabel.text = CommonDataManager.share.userInfo?.userName

        if CommonDataManager.share.categories == nil {
            fetchCategories()
        }
    }

    private func fetchCategories() {
        CategoryAPI().execute(
            onSuccess: { [weak self] (categoryJson: CategoryJson) in
                guard let `self` = self else {
                    return
                }
                CommonDataManager.share.categories = categoryJson.returnJson

                for category in categoryJson.returnJson {
                    print("\(category.categoryId) , \(category.category)")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            },
            onError: { (error: Error) in
                print("errorr \(error.localizedDescription)")
            })
    }

    private func setProperties() {
        wroteButton.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        wroteButton.layer.borderWidth = 1.0
        wroteButton.layer.cornerRadius = 8.0

        bookmarkButton.layer.borderColor = #colorLiteral(red: 0.3176470588, green: 0.4274509804, blue: 0.768627451, alpha: 1)
        bookmarkButton.layer.borderWidth = 1.0
        bookmarkButton.layer.cornerRadius = 8.0
    }

    // MARK: - Actions
    @IBAction private func actionClose(_ sender: UIButton) {
    }

    @IBAction private func mypageButton(_ sender: Any) {
        let myPageStoryBoard = UIStoryboard(name: "MyPage", bundle: nil)
        let myPageNavigationController = myPageStoryBoard.instantiateViewController(withIdentifier: "MyPageViewController")
        navigationController?.pushViewController(myPageNavigationController, animated: true)
    }

    @IBAction private func tappedMyPost(_ sender: UIButton) {
        showItemListViewController("작성한 공구 목록이 없습니다.", navigationTitle: "내가 쓴 글", items: CommonDataManager.share.userOwnedItems)
    }

    @IBAction private func tappedJoinedPost(_ sender: UIButton) {
        showItemListViewController("참여한 공구 목록이 없습니다.", navigationTitle: "참여한 글", items: CommonDataManager.share.userFavoritedItems)
    }

    func showItemListViewController(_ alertTitle: String? = nil, navigationTitle: String, items: [ItemList]?) {
        guard let items = items, !items.isEmpty else {
            popUpAlert(alertTitle)
            return
        }

        if let controller = storyboard?.instantiateViewController(withIdentifier: "ItemListTableViewController") as? ItemListTableViewController {
            controller.navigationItem.setCustomTitle(navigationTitle)
            controller.items = items
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = CommonDataManager.share.categories?.count {
            return count + 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: - 바꾸기
//        showItemListViewController("해당 카테고리의 공구 목록이 없습니다.", navigationTitle: category, items: CommonDataManager.share.categories?[index - 1])

        let index = indexPath.row
        if index == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTitleCell") as? CategoryTitleCell {
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell,
                let category = CommonDataManager.share.categories?[index - 1] {
                cell.configure(category.category)
                return cell
            }
        }
        return UITableViewCell()
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        if indexPath.row != 0,
            let controller = storyboard?.instantiateViewController(withIdentifier: "CategoryItemListTableViewController") as? CategoryItemListTableViewController,
            let category = CommonDataManager.share.categories?[indexPath.row - 1] {
            controller.category = category
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

class CategoryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    func configure(_ title: String) {
        titleLabel.text = title
    }
}

class CategoryTitleCell: UITableViewCell {
}
