//
//  Item.swift
//  groby
//
//  Created by Daeyun Ethan on 16/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct ItemForPost: Codable {
    var imgPathList: [String]?
    var itemAmountLimit: String?
    var itemCategoryId: String?
    var itemTitle: String?

    var tabOne: TabOne?
    var userId: String?
}

struct ItemForPostJSON: Codable {
    let status: String
    let message: String

//    let acceptJson: ItemForPost
}

struct ItemJSON: Codable {
    let status: String
    let message: String

    let returnJson: Item
}

struct Item: Codable {
//    var imgPathList: [String]?
//    var itemAmountLimit: String?
//    var itemCategoryId: String? // category
    var category: String?
    var itemTitle: String?
//    var userId: String?         // writerId
    var writerId: String?

    var itemId: String? = "-1"
    var nowTab: Int? = 0
    var numOfLike: Int? = 0
    var numOfParticipant: Int? = 0
    var participantPercent: Int? = 0 // itemAmountLimit

    var tabOne: TabOne?
    var tabTwo: TabTwo?
    var tabThree: TabThree?
    var tabFour: TabFour?
    var tabFive: TabFive?
}

struct TabOne: Codable {
    var contents: String?
    var endDate: String?
    var location: String?
}

struct TabTwo: Codable {

}

struct TabThree: Codable {

}

struct TabFour: Codable {

}

struct TabFive: Codable {

}
