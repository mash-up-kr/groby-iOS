//
//  Distribution.swift
//  groby
//
//  Created by byungtak on 05/10/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct Distribution: Codable {
    let accountBank: String
    let accountHolder: String
    let accountNum: String
    let amount: Int
    let optionString: String
    let participantId: Int
    let price: Int
    let userName: String
    let userPermission: Int
}

struct DistributionJSON: Codable {
    let status: String
    let message: String
    
    let returnJson: [Distribution]
}
