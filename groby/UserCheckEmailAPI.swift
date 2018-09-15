//
//  UserCheckEmailAPI.swift
//  groby
//
//  Created by Daeyun Ethan on 08/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct UserCheckEmailAPI {
    static let subUrl: String = "checkemail"

    var requestData: RequestData
    var data: RequestData {
        return requestData
    }

    init(_ requestData: RequestData) {
        self.requestData = requestData
    }
}
