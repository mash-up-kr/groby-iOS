//
//  User.swift
//  groby
//
//  Created by Daeyun Ethan on 02/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct User: Codable {
    let accountBank: String?
    let accountHolder: String?
    let accountNum: String?
    let denied: Bool
    let isDeleted: Bool
    let userEmail: String
    let userId: Int
    let userName: String
    let phoneNumber: String?
}

struct UserJSON: Codable {
    let status: String
    let message: String

    let returnJson: User
}
