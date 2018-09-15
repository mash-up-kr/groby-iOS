//
//  UserLoginAPI.swift
//  groby
//
//  Created by Daeyun Ethan on 06/09/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct UserLoginAPI: RequestType {
    static let subUrl: String = "login"

    typealias ResponseType = UserJSON

    var requestData: RequestData
    var data: RequestData {
        return requestData
    }

    init(_ requestData: RequestData) {
        self.requestData = requestData
    }
}
