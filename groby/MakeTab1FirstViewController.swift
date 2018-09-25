//
//  MakeTab1FirstViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("카테고리")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension MakeTab1FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = CommonDataManager.share.categories?.count {
            return count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell, let category = CommonDataManager.share.categories?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(category.category)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MakeTab1SecondViewController") as? MakeTab1SecondViewController, let categoryId = CommonDataManager.share.categories?[indexPath.row].categoryId else {
            return
        }
        CommonDataManager.share.item = Item()

//        CommonDataManager.share.item?.itemCategoryId = "\(categoryId)"
//        controller
        navigationController?.pushViewController(controller, animated: true)
    }
}
