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
    var postLike: String
    var postInProgress: Float
    
    init(postImageUrl: String, postTitle: String, postDate: String, postLike: String, postInProgress: Float = 0.5) {
        self.postImageUrl = postImageUrl
        self.postTitle = postTitle
        self.postDate = postDate
        self.postLike = postLike
        self.postInProgress = postInProgress
    }
}
