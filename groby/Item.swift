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

    let acceptJson: ItemForPost
}

struct ItemJSON: Codable {
    let status: String
    let message: String

    let returnJson: Item
}

struct Item: Codable {
    var category: String?
    var itemTitle: String?
    var writerId: String?
    var writerUserName: String?

    var itemId: String? = "-1"
    var nowTab: Int? = 0
    var numOfLike: Int? = 0
    var numOfParticipant: Int? = 0
    var participantPercent: Int? = 0
    var amountLimit: Int? = 0

    var tabOne: TabOne?
    var tabTwo: TabTwo?
    var tabThree: TabThree?
    var tabFour: TabFour?
    var tabFive: TabFive?

    var imgPathList: [ImagePath]?
}

/*
 {
 "category": "string",
 "editTab": false,
 "imgPathList": [
 "string"
 ],
 "itemAmountLimit": 0,
 "itemId": "string",
 "itemTitle": "string",
 
 "targetTab": 0,
 "writerId": "string"
 }
 */
struct ImagePath: Codable {
    var itemImgPathId: Int
    var tab: Int
    var img_path: String
}

struct TabOne: Codable {
    var contents: String?
    var endDate: String?
    var location: String?
}

struct TabTwo: Codable {
    var contents: String
    var endDate: String
    var optionString: String
    var price: String
}

struct TabThree: Codable {
    var contents: String
}

struct TabFour: Codable {
    var arrivedTime: String
    var contents: String
}

struct TabFive: Codable {
    var contents: String
    var locationDetail: String
}
