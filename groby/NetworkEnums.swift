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

enum GrobyURL: String {
    static let base: String = "http://ec2-13-125-62-50.ap-northeast-2.compute.amazonaws.com/"

    case user = "user/"
    case main = "api/"
    case item = "item/"
    case category = "category/"
}
