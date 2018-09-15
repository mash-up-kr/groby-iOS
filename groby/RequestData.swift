//
//  RequestData.swift
//  groby
//
//  Created by 이재성 on 26/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

struct RequestData {
    let path: String
    let method: HTTPMethod
    let params: [String: Any?]?
    let headers: [String: String]?

    init (
        path: String,
        method: HTTPMethod = .get,
        params: [String: Any?]? = nil,
        headers: [String: String]? = ["Content-Type": "application/x-www-form-urlencoded"]
        ) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}
