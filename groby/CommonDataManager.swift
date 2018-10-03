//
//  CommonDataManager.swift
//  groby
//
//  Created by Daeyun Ethan on 08/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

class CommonDataManager {
    static let share = CommonDataManager()

    var userInfo: User?
    var categories: [Category]?
    var itemForPost: ItemForPost?
    var item: Item?

    var userFavoritedItems: [ItemList]?
    var userOwnedItems: [ItemList]?
    var mainItems: MainItemList?
}
