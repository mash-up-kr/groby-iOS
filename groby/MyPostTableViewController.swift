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
        
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.사쿠라 키링 진행중입니다.사쿠라 키링 진행중입니다.사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postLike: "63"))
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postLike: "63"))
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postLike: "63"))
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postLike: "63"))
        posts.append(Post(postImageUrl: "asdf", postTitle: "사쿠라 키링 진행중입니다.", postDate: "2018-08-30", postLike: "63"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MyPostTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MyPostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "my_post_cell", for: indexPath) as? MyPostTableViewCell else { return UITableViewCell() }
        let post = posts[indexPath.row]
        
        cell.postTitle.text = post.postTitle
        cell.postDate.text = post.postDate
        cell.postLikeOrProgress.text = post.postLike
        cell.postInProgress.setProgress(0.5, animated: false)
        
        return cell
    }
}
