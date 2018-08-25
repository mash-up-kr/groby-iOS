//
//  NetworkEnums.swift
//  groby
//
//  Created by 이재성 on 26/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import Foundation

enum ConnError: Swift.Error {
    case invalidURL
    case noData
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
