//
//  ViewController.swift
//  groby
//
//  Created by 이재성 on 03/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MyPostTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var posts: [Post] = []
    
    private let cellIdentifier = "my_post_cell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyPostTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyPostTableViewCell
        
        let post = posts[indexPath.row]
        
        cell.postTitle.text = post.postTitle
        cell.postDate.text = post.postDate
        cell.postLike.text = post.postLike
        
        return cell
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
        // Dispose of any resources that can be recreated.
    }


}

