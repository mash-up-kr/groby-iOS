//
//  CategoryJson.swift
//  groby
//
//  Created by byungtak on 2018. 9. 4..
//  Copyright © 2018년 mashup. All rights reserved.
//

import Foundation

struct CategoryJson: Codable {
    let status: String
    let message: String
    
    let returnJson: [Category]
}

