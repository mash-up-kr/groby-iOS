//
//  ItemList.swift
//  groby
//
//  Created by Daeyun Ethan on 16/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct ItemList: Codable {
    let amountLimit: Int
    let dueDate: String
    let itemId: String
    let likeNum: String
    let nowTab: Int
    let participantNum: Int?
    let participantPercent: Int?
    let progress: Int?
    let thumnailURL: String
    let title: String
}

struct ItemListJSON: Codable {
    let status: String
    let message: String

    let returnJson: [ItemList]
}
