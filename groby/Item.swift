//
//  Item.swift
//  groby
//
//  Created by Daeyun Ethan on 16/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct ItemJSON: Codable {
    let status: String
    let message: String

//    let returnJson: [Item]
}

struct Item: Codable {
    var imgPathList: [String]?
    var itemAmountLimit: String?
    var itemCategoryId: String?
    var itemTitle: String?
    var userId: String?
    var tab1: TapOne?
}

struct TapOne: Codable {
    var contents: String?
    var endDate: String?
    var location: String?
}
