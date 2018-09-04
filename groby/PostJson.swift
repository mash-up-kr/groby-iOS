//
//  Post.swift
//  groby
//
//  Created by byungtak on 2018. 8. 3..
//  Copyright © 2018년 mashup. All rights reserved.
//

import Foundation
//
//{
//    "status": "OK",
//    "message": "All Category",
//    "returnJson": [
//    {
//    "categotyId": 1,
//    "category": "의류"
//    },
//    {
//    "categotyId": 2,
//    "category": "잡화"
//    },
//    {
//    "categotyId": 3,
//    "category": "식품"
//    },
//    {
//    "categotyId": 4,
//    "category": "화장품"
//    },
//    {
//    "categotyId": 5,
//    "category": "기타"
//    }
//    ]
//}
//
struct Post : Codable {
    
    let status: String
    let message: String
    
    let posts: [Post]
    
    var postImageUrl: String
    var postTitle: String
    var postDate: String
    var postInProgressOrLikeCount: Int

    init(postImageUrl: String, postTitle: String, postDate: String, postInProgressOrLikeCount: Int) {
        self.postImageUrl = postImageUrl
        self.postTitle = postTitle
        self.postDate = postDate
        self.postInProgressOrLikeCount = postInProgressOrLikeCount
    }
}
