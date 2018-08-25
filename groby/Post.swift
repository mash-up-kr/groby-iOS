//
//  Post.swift
//  groby
//
//  Created by byungtak on 2018. 8. 3..
//  Copyright © 2018년 mashup. All rights reserved.
//

import Foundation

struct Post {
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
