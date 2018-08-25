//
//  ViewController.swift
//  groby
//
//  Created by 이재성 on 03/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MyPostTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var posts: [Post] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setCustomTitle("내가 쓴 글")
        let newBackButton = UIBarButtonItem(title: " ",
                                            style: .plain, target: self, action: nil)

        navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.사쿠라 키링 진행중입니다.사쿠라 키링 진행중입니다.사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postInProgressOrLikeCount: 63))
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postInProgressOrLikeCount: 63))
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postInProgressOrLikeCount: 63))
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postInProgressOrLikeCount: 63))
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postInProgressOrLikeCount: 63))
    }
}

extension MyPostTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "my_post_cell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }

        let post = posts[indexPath.row]

        cell.postTitle.text = post.postTitle
        cell.postDate.text = post.postDate

        if true {
            cell.postLikeOrProgress.text = "좋아요 수"
            cell.postLikeOrProgressCount.text = String(post.postInProgressOrLikeCount)
        } else {
            cell.postLikeOrProgress.text = "진행률"
            cell.postLikeOrProgressCount.text = String(post.postInProgressOrLikeCount)
        }

        return cell
    }
}
